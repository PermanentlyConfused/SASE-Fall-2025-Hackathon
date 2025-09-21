async function loadEvents() {
  try {
    const response = await fetch("http://127.0.0.1:8081/getHobbies");
    const result = await response.json();
    const hobbies = result.payload;

    const hobbyList = document.getElementById("hobbyList");
    hobbies.forEach((hobby) => {
      const checkbox = document.createElement("input");
      checkbox.type = "checkbox";
      checkbox.id = `hobby-${hobby.hobbyid}`;
      checkbox.name = "hobbies";
      checkbox.value = hobby.hobbyid;

      const label = document.createElement("label");
      label.htmlFor = checkbox.id;
      label.textContent = hobby.hobbyname;

      const div = document.createElement("div");
      div.appendChild(checkbox);
      div.appendChild(label);

      hobbyList.appendChild(div);
    });
  } catch (error) {
    console.error("Failed to load hobbies:", error);
  }
}

document.getElementById("hobbyForm").addEventListener("submit", async (e) => {
  e.preventDefault();

  const selected = Array.from(
    document.querySelectorAll('input[name="hobbies"]:checked')
  ).map((cb) => parseInt(cb.value));

  console.log("Selected hobbies:", selected);

  try {
    const response = await fetch("http://127.0.0.1:8081/saveHobbies", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ hobbies: selected }),
    });

    const result = await response.json();
    alert("Hobbies saved successfully!");
    console.log(result);
  } catch (error) {
    console.error("Error saving hobbies:", error);
    alert("Failed to save hobbies.");
  }
});

async function checkSavedHobbies() {
  try {
    const response = await fetch("http://127.0.0.1:8081/getSavedHobbies");
    const result = await response.json();

    if (result.payload && result.payload.length > 0) {
      const hobbiesString = result.payload[0].hobbiesString;
      if (hobbiesString == null) {
        console.log("No saved hobbies yet");
        return;
      }

      console.log("Raw hobbies string from DB:", hobbiesString);

      const savedHobbyIds = hobbiesString.split(",").map((id) => parseInt(id));
      console.log("Parsed saved hobby IDs:", savedHobbyIds);

      savedHobbyIds.forEach((id) => {
        const checkbox = document.getElementById(`hobby-${id}`);
        if (checkbox) {
          checkbox.checked = true;

          const label = checkbox.nextElementSibling;
          //   if (label && label.tagName === "LABEL") {
          //     label.style.color = "#888";
          //   }
        }
      });
    } else {
      console.warn("No saved hobbies returned.");
    }
  } catch (error) {
    console.error("Error fetching saved hobbies:", error);
  }
}

(async () => {
  await loadEvents(); // Load hobbies
  await checkSavedHobbies(); // Gray out selected ones
})();
