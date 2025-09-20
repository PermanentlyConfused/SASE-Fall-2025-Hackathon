# 1 set up env and store secrets
import getpass
import os
from datetime import datetime
from dotenv import load_dotenv

from typing import Annotated
from typing_extensions import TypedDict
from langgraph.graph.message import add_messages

from langgraph.graph import StateGraph, START, END
from langgraph.checkpoint.memory import MemorySaver
from langchain_core.messages import ToolMessage, HumanMessage, AIMessage
from langchain_core.tools import InjectedToolCallId, tool
from langgraph.types import Command, interrupt
from langchain.chat_models import init_chat_model

from langgraph.prebuilt import ToolNode, tools_condition

from langchain_tavily import TavilySearch

# Utilities
# I got the utilities map. This part can be done with a parser.

load_dotenv()
# Events
if not os.getenv("GEMINI_API_KEY"):
    os.environ["GEMINI_API_KEY"] = getpass.getpass("Enter API key for Google Gemini: ")

if not os.getenv("TAVILY_API_KEY"):
    os.environ["TAVILY_API_KEY"] = getpass.getpass("Enter API key for Tavily Search: ")

# psql events import format
class State(TypedDict):
  messages: Annotated[list, add_messages]
#  description: str
#  eventTime: datetime
#  address: str

model = init_chat_model("gemini-2.0-flash", model_provider="google_genai", google_api_key= "AIzaSyBeVoIqH2D-bY0a9EcK7VRrdzovIIlD3-Q") # art pls fix this for me :>
tool = TavilySearch(max_results=20)

# custom tool for parsing:
import requests
@tool
def urlHtmlextract(url: str):
  """Use this to get the html of all the events urls"""
  helper = requests.get(url)
  download = helper.text
  return{
    "html": download
   }

tools = [tool]






simpleModel = model.bind_tools(tools)

graph_builder = StateGraph(State)
def chatbot(state: State):
  message = simpleModel.invoke(state["messages"])
  assert len(message.tool_calls) <= 1
  return {"messages": [message]}

tools_node = ToolNode(tools=tools)

graph_builder.add_node("chatbot with search", chatbot)
graph_builder.add_node("tools", tools_node)


graph_builder.add_conditional_edges("chatbot with search", tools_condition)
graph_builder.add_edge("tools", "chatbot with search")
graph_builder.add_edge(START, "chatbot with search")
memory = MemorySaver()
graph = graph_builder.compile(checkpointer = memory)

from PIL import Image
from io import BytesIO

try:
    png_data = graph.get_graph().draw_mermaid_png()
    image = Image.open(BytesIO(png_data)) 
#    image.show()
except Exception as e:
    print(e)
    pass

config = {"configurable": {"thread_id": "test"}}

userinp = input("Search: ")

events = graph.stream({"messages": [{"role": "user", "content": userinp}]},
                      config = config,
                      stream_mode = "values"
                      )
for event in events:
  if "messages" in event:
    event["messages"][-1].pretty_print()

# next part is to write a parsing tool for the tavily search. let gemini use the tool and figure out how to parse
events = []
event = {}
