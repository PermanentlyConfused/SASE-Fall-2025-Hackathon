async function loadEvents() {
  try {
    const response = await fetch("http://127.0.0.1:8081/events");
    const data = await response.json();

    var EventsList = [];
    for (let i = 0; i < data.payload.length; i++) {
      const item = data.payload[i];
      const description = item.Description;
      const address = item.Address;
      const date = new Date(item.StartDate).toLocaleDateString();

      EventsList.push(
        `<div class="event-card">
            <div class="event-icon">
                <div class="event-info">
                    <h2>🎉 ${description}</h2>
                    <span class="event-time">📅 ${date}</span>
                    <h3>📍 ${address}</h3>
                </div>
            </div>
        </div>`
      );
    }
    document.getElementById("events-container").innerHTML = EventsList.join("");
  } catch (error) {
    console.error("Error fetching events:", error);
  }
}

document.addEventListener("DOMContentLoaded", loadEvents);
