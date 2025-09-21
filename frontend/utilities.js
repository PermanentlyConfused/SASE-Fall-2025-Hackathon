async function UpdateAllUtilities() {
  const electricContainer = document.getElementById("electricity");
  const response = await fetch("http://127.0.0.1:8081/getElectric");
  const result = await response.json();
  const electric = result.payload;

  electricContainer.innerHTML = `
          <p>${electric[0].utilityname}</p>
          <p2>${electric[0].utilityphone}</p2>
          `;

  const gasContainer = document.getElementById("gas");
  const gasRes = await fetch("http://127.0.0.1:8081/getGas");
  const result2 = await gasRes.json();
  const gas = result2.payload;
  gasContainer.innerHTML = `
          <p>${gas[0].utilityname}</p>
          <p2>${gas[0].utilityphone}</p2>
          `;
}

UpdateAllUtilities();
