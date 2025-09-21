async function loadEvents() {
  try {
    const response = await fetch("http://127.0.0.1:8080/getHobbies");
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
    const response = await fetch("http://127.0.0.1:8080/saveHobbies", {
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

loadEvents();
