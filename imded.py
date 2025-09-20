# 1 set up env and store secrets
import getpass
import os
from datetime import datetime
from dotenv import load_dotenv
import operator

from typing import Annotated
from typing_extensions import TypedDict
from langgraph.graph.message import add_messages

from langgraph.graph import StateGraph, START, END
from langgraph.checkpoint.memory import MemorySaver
from langchain_core.messages import ToolMessage, HumanMessage, AIMessage
from langchain_core.messages import AnyMessage
from langchain_core.tools import InjectedToolCallId, tool
from langgraph.types import Command, interrupt
from langchain.chat_models import init_chat_model

from langgraph.prebuilt import ToolNode, tools_condition

from langchain_tavily import TavilySearch
from langchain_google_genai import ChatGoogleGenerativeAI
from langchain.prompts import ChatPromptTemplate
import logging
import json  # Import the json module to parse the LLM's output
logger = logging.getLogger(__name__)

# Utilities
# I got the utilities map. This part can be done with a parser.

load_dotenv()
# Events
if not os.getenv("GOOGLE_API_KEY"):
    os.environ["GOOGLE_API_KEY"] = getpass.getpass("Enter API key for Google Gemini: ")

if not os.getenv("TAVILY_API_KEY"):
    os.environ["TAVILY_API_KEY"] = getpass.getpass("Enter API key for Tavily Search: ")

# psql events import format
class State(TypedDict):
  messages: Annotated[list, add_messages]
  sql: list
#  eventTime: datetime
#  address: str

@tool
def eventsExtractor(tool_call_id: Annotated[str, InjectedToolCallId],
                    content: str):
    """Takes the tavily results and organizes them into date, location, and description"""
    llm = ChatGoogleGenerativeAI(model = "gemini-2.0-flash")
    prompt = ChatPromptTemplate.from_messages([
      ("system", """You are world-class expert at extracting information about events from messy HTML code.
       Your sole purpose is to find details about an event from the provided HTML and return them in a structured JSON format.
       Ignore all irrelevant information like navigation, ads, sidebars, and footer links.
       Focus on the pain content on the page.
       
       You MUST return ONLY a valid JSON object with the following keys:
        - "name": (string) The name of the event.
        - "date": (string) The date of the event mentioned in the html. Format it clearly.
        - "location": (string) The exact address of this location including street number, street, town, state, zipcode. If there is not a specific address, search up the venue name using the website domain and the provided location information, then add" (unsure)" to the end.
        - "domain": (string) website domain name where the url was provided.

        Do not add any other text before or after the JSON object.
        Do not use markdown formatting (no ```json or ```)
       """),
       ("human", "Extract the event details from the following HTML: \n\n {html}")
   ])

    chain = prompt | llm

    try:
    # 4. Invoke the chain with the HTML content
        llm_output = chain.invoke({"html": content})
        print(llm_output.content)
    
    # 5. The LLM output should be a raw JSON string. Parse it into a Python dictionary.
        event = json.loads(llm_output.content)
    
    # 6. Return the dictionary for the agent to use
        return Command(update = {"sql": event, "messages": [ToolMessage("Succesfully summarized events", tool_call_id = tool_call_id)]})

    except json.JSONDecodeError as e:
        logger.error(f"LLM returned invalid JSON: {llm_output.content}. Error: {e}")
        return Command(update = {"sql": llm_output.content, "messages": [ToolMessage(f"error : Failed to parse the HTML content. Reason: {str(e)}", tool_call_id = tool_call_id)]})
    except Exception as e:
        logger.error(f"Error parsing HTML with LLM: {e}")
        return Command(update = {"sql": llm_output.content, "messages": [ToolMessage(f"error : Failed to parse the HTML content. Reason: {str(e)}", tool_call_id = tool_call_id)]})

model = init_chat_model("gemini-2.0-flash", model_provider="google_genai")
tool = TavilySearch(max_results=25, include_raw_content = True, time_range = 'week')

# custom tool for parsing:
tools = [tool, eventsExtractor]
   
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
snapshot = graph.get_state(config)
save = []
print("================================= Tool Output =================================")
for k, v in snapshot.values.items():
   if k in ("sql"):
      save.append([v])
print(save)
