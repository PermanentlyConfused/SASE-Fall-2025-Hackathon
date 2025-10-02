const API_CONFIG = {
  WEATHER_API_KEY: "097a29234019d1584d2e58988bf19873",
};
const GEOCODING_API_KEY = "975dc8a1e9df4b3f968ae19714f8131e";

let currentLocation = {
  address: "",
  coordinates: "",
  lastUpdated: "Just now",
};

function randomBackground() {
  const backgrounds = [
    // `url("data:image/svg+xml,%3csvg xmlns='http://www3.org/2000/svg' version='1.1' xmlns:xlink='http://www.w3.org/1999/xlink' xmlns:svgjs='http://svgjs.dev/svgjs' width='1440' height='560' preserveAspectRatio='none' viewBox='0 0 1440 560'%3e%3cg mask='url(%26quot%3b%23SvgjsMask1035%26quot%3b)' fill='none'%3e%3crect width='1440' height='560' x='0' y='0' fill='%230e2a47'%3e%3c/rect%3e%3cpath d='M292.11 514.69 a171.53 171.53 0 1 0 343.06 0 a171.53 171.53 0 1 0 -343.06 0z' fill='rgba(13%2c 83%2c 159%2c 0.4)' class='triangle-float1'%3e%3c/path%3e%3cpath d='M122.80826059798935 178.8775069261876L198.3131540540027 103.37261347017423 122.80826059798932 27.86772001416088 47.30336714197597 103.37261347017426z' fill='rgba(13%2c 83%2c 159%2c 0.4)' class='triangle-float3'%3e%3c/path%3e%3cpath d='M-10.35 512.47 a163.66 163.66 0 1 0 327.32 0 a163.66 163.66 0 1 0 -327.32 0z' fill='rgba(13%2c 83%2c 159%2c 0.4)' class='triangle-float1'%3e%3c/path%3e%3cpath d='M359.37 214.24 a171.59 171.59 0 1 0 343.18 0 a171.59 171.59 0 1 0 -343.18 0z' fill='rgba(13%2c 83%2c 159%2c 0.4)' class='triangle-float2'%3e%3c/path%3e%3cpath d='M1192.3261350461466 158.87364069850142L1209.4890552077866 99.01942502830954 1111.1262716216788 103.20215262094543z' fill='rgba(13%2c 83%2c 159%2c 0.4)' class='triangle-float3'%3e%3c/path%3e%3cpath d='M319.0131708405063 406.6401162883448L372.67348014829236 447.0760596969956 406.49724060737555 346.3676240309911z' fill='rgba(13%2c 83%2c 159%2c 0.4)' class='triangle-float1'%3e%3c/path%3e%3cpath d='M797.77 185.19 a155.79 155.79 0 1 0 311.58 0 a155.79 155.79 0 1 0 -311.58 0z' fill='rgba(13%2c 83%2c 159%2c 0.4)' class='triangle-float2'%3e%3c/path%3e%3cpath d='M67.27 448.91 a129.94 129.94 0 1 0 259.88 0 a129.94 129.94 0 1 0 -259.88 0z' fill='rgba(13%2c 83%2c 159%2c 0.4)' class='triangle-float2'%3e%3c/path%3e%3cpath d='M905.06 503.22 a141.22 141.22 0 1 0 282.44 0 a141.22 141.22 0 1 0 -282.44 0z' fill='rgba(13%2c 83%2c 159%2c 0.4)' class='triangle-float2'%3e%3c/path%3e%3c/g%3e%3cdefs%3e%3cmask id='SvgjsMask1035'%3e%3crect width='1440' height='560' fill='white'%3e%3c/rect%3e%3c/mask%3e%3cstyle%3e %40keyframes float1 %7b 0%25%7btransform: translate(0%2c 0)%7d 50%25%7btransform: translate(-10px%2c 0)%7d 100%25%7btransform: translate(0%2c 0)%7d %7d .triangle-float1 %7b animation: float1 5s infinite%3b %7d %40keyframes float2 %7b 0%25%7btransform: translate(0%2c 0)%7d 50%25%7btransform: translate(-5px%2c -5px)%7d 100%25%7btransform: translate(0%2c 0)%7d %7d .triangle-float2 %7b animation: float2 4s infinite%3b %7d %40keyframes float3 %7b 0%25%7btransform: translate(0%2c 0)%7d 50%25%7btransform: translate(0%2c -10px)%7d 100%25%7btransform: translate(0%2c 0)%7d %7d .triangle-float3 %7b animation: float3 6s infinite%3b %7d %3c/style%3e%3c/defs%3e%3c/svg%3e")`,
    `url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' version='1.1' xmlns:xlink='http://www.w3.org/1999/xlink' xmlns:svgjs='http://svgjs.dev/svgjs' width='1440' height='560' preserveAspectRatio='none' viewBox='0 0 1440 560'%3e%3cg mask='url(%26quot%3b%23SvgjsMask1007%26quot%3b)' fill='none'%3e%3crect width='1440' height='560' x='0' y='0' fill='%230e2a47'%3e%3c/rect%3e%3cpath d='M1121.059639829727 234.96029706926404L1163.7415283634011 95.82850762737057 1039.3041705444512 122.27848454866881z' fill='rgba(28%2c 83%2c 142%2c 0.4)' class='triangle-float1'%3e%3c/path%3e%3cpath d='M1059.6023295516864 513.3550551719883L958.4503329513198 404.6753493914302 918.3445186002942 528.1083539645887z' fill='rgba(28%2c 83%2c 142%2c 0.4)' class='triangle-float2'%3e%3c/path%3e%3cpath d='M772.3787410977179 213.38334698815822L836.9832849971029 280.2833106045849 903.8832486135296 215.67876670519996 839.2787047141446 148.77880308877323z' fill='rgba(28%2c 83%2c 142%2c 0.4)' class='triangle-float1'%3e%3c/path%3e%3cpath d='M1018.4497555356796 444.0578181755852L968.7648934985875 361.3683217038366 935.760259063931 493.7426802126774z' fill='rgba(28%2c 83%2c 142%2c 0.4)' class='triangle-float3'%3e%3c/path%3e%3cpath d='M1132.732%2c745.331C1183.21%2c744.9%2c1228.276%2c713.48%2c1251.372%2c668.593C1272.696%2c627.149%2c1264.042%2c578.054%2c1239.042%2c538.718C1215.944%2c502.376%2c1175.767%2c480.439%2c1132.732%2c481.922C1092.088%2c483.323%2c1060.503%2c511.496%2c1038.399%2c545.633C1013.527%2c584.045%2c990.982%2c629.273%2c1010.528%2c670.65C1032.382%2c716.914%2c1081.568%2c745.768%2c1132.732%2c745.331' fill='rgba(28%2c 83%2c 142%2c 0.4)' class='triangle-float1'%3e%3c/path%3e%3cpath d='M1020.8425032623413 556.1152358559062L1052.7490017076805 457.91713086177833 889.498594993819 459.15643569083363z' fill='rgba(28%2c 83%2c 142%2c 0.4)' class='triangle-float1'%3e%3c/path%3e%3cpath d='M370.082%2c7.655C387.369%2c7.972%2c407.118%2c6.388%2c415.646%2c-8.652C424.109%2c-23.577%2c415.723%2c-41.558%2c406.007%2c-55.7C397.759%2c-67.706%2c384.605%2c-73.86%2c370.082%2c-74.976C352.734%2c-76.309%2c332.716%2c-76.587%2c323.123%2c-62.071C312.886%2c-46.581%2c316.949%2c-25.671%2c327.321%2c-10.271C336.574%2c3.469%2c353.52%2c7.351%2c370.082%2c7.655' fill='rgba(28%2c 83%2c 142%2c 0.4)' class='triangle-float3'%3e%3c/path%3e%3cpath d='M666.101040158371 341.6949049635378L574.4002085207713 272.5933718852301 505.29867544246366 364.2942035228298 596.9995070800633 433.39573660113746z' fill='rgba(28%2c 83%2c 142%2c 0.4)' class='triangle-float3'%3e%3c/path%3e%3cpath d='M614.8512540376023 376.9809256775514L583.2906118406775 513.6850859304458 751.5554142904966 408.54156787447624z' fill='rgba(28%2c 83%2c 142%2c 0.4)' class='triangle-float2'%3e%3c/path%3e%3cpath d='M966.887%2c206.086C1001.686%2c206.73%2c1037.559%2c198.622%2c1057.384%2c170.015C1080.124%2c137.2%2c1087.969%2c93.944%2c1068.913%2c58.861C1049.111%2c22.406%2c1008.365%2c2.582%2c966.887%2c3.409C926.804%2c4.208%2c890.153%2c27.216%2c871.669%2c62.792C854.457%2c95.919%2c861.349%2c135.678%2c882.01%2c166.77C900.506%2c194.604%2c933.474%2c205.468%2c966.887%2c206.086' fill='rgba(28%2c 83%2c 142%2c 0.4)' class='triangle-float2'%3e%3c/path%3e%3cpath d='M1067.055%2c614.362C1107.394%2c615.976%2c1144.756%2c593.653%2c1165.612%2c559.086C1187.204%2c523.299%2c1192.765%2c477.85%2c1170.918%2c442.218C1149.862%2c407.877%2c1107.337%2c398.512%2c1067.055%2c398.343C1026.391%2c398.172%2c981.519%2c405.849%2c961.669%2c441.339C942.12%2c476.291%2c960.442%2c517.506%2c981.275%2c551.709C1001.016%2c584.12%2c1029.135%2c612.844%2c1067.055%2c614.362' fill='rgba(28%2c 83%2c 142%2c 0.4)' class='triangle-float3'%3e%3c/path%3e%3cpath d='M1164.357%2c427.713C1204.791%2c425.946%2c1246.274%2c414.184%2c1266.77%2c379.284C1287.487%2c344.007%2c1278.874%2c301.236%2c1259.926%2c264.979C1239.125%2c225.176%2c1209.263%2c184.005%2c1164.357%2c183.315C1118.687%2c182.613%2c1086.467%2c222.445%2c1063.564%2c261.963C1040.575%2c301.63%2c1021.352%2c349.794%2c1045.173%2c388.967C1068.437%2c427.223%2c1119.626%2c429.668%2c1164.357%2c427.713' fill='rgba(28%2c 83%2c 142%2c 0.4)' class='triangle-float3'%3e%3c/path%3e%3cpath d='M676.4025745658197 91.57592710739769L628.1462105595358 133.5245443532926 715.1973184315202 184.93478173977104z' fill='rgba(28%2c 83%2c 142%2c 0.4)' class='triangle-float3'%3e%3c/path%3e%3c/g%3e%3cdefs%3e%3cmask id='SvgjsMask1007'%3e%3crect width='1440' height='560' fill='white'%3e%3c/rect%3e%3c/mask%3e%3cstyle%3e %40keyframes float1 %7b 0%25%7btransform: translate(0%2c 0)%7d 50%25%7btransform: translate(-10px%2c 0)%7d 100%25%7btransform: translate(0%2c 0)%7d %7d .triangle-float1 %7b animation: float1 5s infinite%3b %7d %40keyframes float2 %7b 0%25%7btransform: translate(0%2c 0)%7d 50%25%7btransform: translate(-5px%2c -5px)%7d 100%25%7btransform: translate(0%2c 0)%7d %7d .triangle-float2 %7b animation: float2 4s infinite%3b %7d %40keyframes float3 %7b 0%25%7btransform: translate(0%2c 0)%7d 50%25%7btransform: translate(0%2c -10px)%7d 100%25%7btransform: translate(0%2c 0)%7d %7d .triangle-float3 %7b animation: float3 6s infinite%3b %7d %3c/style%3e%3c/defs%3e%3c/svg%3e")`,
    `url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' version='1.1' xmlns:xlink='http://www.w3.org/1999/xlink' xmlns:svgjs='http://svgjs.dev/svgjs' width='1440' height='560' preserveAspectRatio='none' viewBox='0 0 1440 560'%3e%3cg mask='url(%26quot%3b%23SvgjsMask1005%26quot%3b)' fill='none'%3e%3crect width='1440' height='560' x='0' y='0' fill='rgba(0%2c 148%2c 77%2c 1)'%3e%3c/rect%3e%3cpath d='M798.5816296659407 489.7093313384783L896.2430020458419 594.6386414173139 934.9648167561261 475.4651497539215z' fill='rgba(5%2c 47%2c 6%2c 0.4)' class='triangle-float3'%3e%3c/path%3e%3cpath d='M75 479.58 a176.67 176.67 0 1 0 353.34 0 a176.67 176.67 0 1 0 -353.34 0z' fill='rgba(5%2c 47%2c 6%2c 0.4)' class='triangle-float2'%3e%3c/path%3e%3cpath d='M1362.279000534807 239.1410518947354L1242.0851193374801 295.18837916042105 1298.1324466031656 415.382260357748 1418.3263278004927 359.33493309206233z' fill='rgba(5%2c 47%2c 6%2c 0.4)' class='triangle-float2'%3e%3c/path%3e%3cpath d='M188.78354670679911 400.0673064123728L146.0594978485829 319.7150570179759 46.89314818609563 423.9772550024987z' fill='rgba(5%2c 47%2c 6%2c 0.4)' class='triangle-float3'%3e%3c/path%3e%3cpath d='M1213.34 375.25 a95.8 95.8 0 1 0 191.6 0 a95.8 95.8 0 1 0 -191.6 0z' fill='rgba(5%2c 47%2c 6%2c 0.4)' class='triangle-float3'%3e%3c/path%3e%3cpath d='M905.4342443067684 298.46839861649795L893.611800877463 185.9853630906574 781.1287653516224 197.8078065199628 792.9512087809278 310.29084204580334z' fill='rgba(5%2c 47%2c 6%2c 0.4)' class='triangle-float2'%3e%3c/path%3e%3cpath d='M100.634%2c205.99C124.416%2c206.058%2c151.825%2c206.628%2c164.235%2c186.341C176.965%2c165.532%2c167.264%2c139.278%2c153.944%2c118.842C142.003%2c100.522%2c122.489%2c89.53%2c100.634%2c88.765C77.208%2c87.945%2c53.184%2c95.196%2c40.44%2c114.869C26.617%2c136.208%2c23.646%2c164.765%2c37.66%2c185.979C50.672%2c205.676%2c77.027%2c205.922%2c100.634%2c205.99' fill='rgba(5%2c 47%2c 6%2c 0.4)' class='triangle-float2'%3e%3c/path%3e%3cpath d='M911.48 519.44 a176.8 176.8 0 1 0 353.6 0 a176.8 176.8 0 1 0 -353.6 0z' fill='rgba(5%2c 47%2c 6%2c 0.4)' class='triangle-float1'%3e%3c/path%3e%3cpath d='M1197.673%2c75.083C1213.071%2c74.436%2c1224.402%2c62.887%2c1232.698%2c49.898C1241.931%2c35.443%2c1250.922%2c18.669%2c1243.62%2c3.149C1235.46%2c-14.193%2c1216.806%2c-25.667%2c1197.673%2c-24.54C1179.968%2c-23.497%2c1168.443%2c-7.661%2c1160.234%2c8.061C1152.773%2c22.349%2c1149.286%2c39.002%2c1157.147%2c53.074C1165.182%2c67.458%2c1181.212%2c75.775%2c1197.673%2c75.083' fill='rgba(5%2c 47%2c 6%2c 0.4)' class='triangle-float2'%3e%3c/path%3e%3c/g%3e%3cdefs%3e%3cmask id='SvgjsMask1005'%3e%3crect width='1440' height='560' fill='white'%3e%3c/rect%3e%3c/mask%3e%3cstyle%3e %40keyframes float1 %7b 0%25%7btransform: translate(0%2c 0)%7d 50%25%7btransform: translate(-10px%2c 0)%7d 100%25%7btransform: translate(0%2c 0)%7d %7d .triangle-float1 %7b animation: float1 5s infinite%3b %7d %40keyframes float2 %7b 0%25%7btransform: translate(0%2c 0)%7d 50%25%7btransform: translate(-5px%2c -5px)%7d 100%25%7btransform: translate(0%2c 0)%7d %7d .triangle-float2 %7b animation: float2 4s infinite%3b %7d %40keyframes float3 %7b 0%25%7btransform: translate(0%2c 0)%7d 50%25%7btransform: translate(0%2c -10px)%7d 100%25%7btransform: translate(0%2c 0)%7d %7d .triangle-float3 %7b animation: float3 6s infinite%3b %7d %3c/style%3e%3c/defs%3e%3c/svg%3e")`,
  ];
  const randomIndex = Math.floor(Math.random() * backgrounds.length);
  const randomImage = backgrounds[randomIndex];

  document.getElementById("help").style.backgroundImage = `${randomImage}`;
}

// Real-time weather update
function updateWeather(lat, lon) {
  const weatherInfo = document.getElementById("weather-info");
  const url = `https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&units=metric&appid=${API_CONFIG.WEATHER_API_KEY}`;

  fetch(url)
    .then((res) => res.json())
    .then((data) => {
      const temperature = Math.round(data.main?.temp ?? 25);
      const condition = data.weather?.[0]?.description ?? "Clear";

      weatherInfo.innerHTML = `
              <div class="weather-display">
                  <div class="temperature">${temperature}°C</div>
                  <div class="condition">${condition}</div>
              </div>
          `;
    })
    .catch((err) => {
      console.error("Weather API error:", err);
      // If weather API fails, render a local fallback so the UI keeps showing a nice card
      renderFallbackWeather(weatherInfo);
    });
}

// Render a fallback weather card when API or geolocation is not available
function renderFallbackWeather(container) {
  if (!container) return;
  container.innerHTML = `
            <div class="weather-display">
                <div class="temperature">10°C</div>
                <div class="condition">scattered clouds</div>
            </div>
        `;
}

function getTownData(lat, lon) {
  const help = `http://api.openweathermap.org/geo/1.0/reverse?lat=${lat}&lon=${lon}&appid=${API_CONFIG.WEATHER_API_KEY}`;
  fetch(help)
    .then((res) => res.json())
    .then((data) => {
      console.log("Weather API response:", data); // This will log everything from the response
    })
    .catch((err) => {
      console.error("Weather API error:", err);
      // If weather API fails, render a local fallback so the UI keeps showing a nice card
      renderFallbackWeather(weatherInfo);
    });
}
// Real-time GPS location + OpenCage reverse geocoding
async function getCurrentLocation() {
  const response = await fetch("http://127.0.0.1:8081/currentLoc");
  const data = await response.json();
  if (data.payload.length > 0) {
    const item = data.payload[0]; // assuming only one location

    lat = parseFloat(item.Lat);
    lng = parseFloat(item.Long);
  }
  updateWeather(lat, lng); // updated here
  getTownData(lat, lng);
}

// Update location display
function updateLocationDisplay() {
  const locationInfo = document.getElementById("location-info");
  if (locationInfo) {
    locationInfo.innerHTML = `
            <div class="location-display">
                <div class="location-icon">📍</div>
                <div class="location-text">
                    <div>${currentLocation.address}</div> <!-- Sadəcə ünvan -->
                </div>
            </div>
        `;
  }
}

// Initialize main event
async function initializeMainEvent() {
  const mainEvent = document.getElementById("main-event");

  try {
    const response = await fetch("http://127.0.0.1:8081/getRandomEvents");

    if (!response.ok) {
      throw new Error("Failed to fetch event data");
    }

    const { payload } = await response.json();

    const eventTitleElement = mainEvent.querySelector("h2");
    const eventDescriptionElement =
      mainEvent.querySelector(".event-description");
    const eventAddressElement = mainEvent.querySelector(".event-address");
    eventTitleElement.textContent = `🎉 ${payload.Description}`;
    eventDescriptionElement.textContent = `🗓️ ${new Date(
      payload.StartDate
    ).toLocaleDateString()}`;
    eventAddressElement.textContent = `📍 ${payload.Address}`;
  } catch (error) {
    console.error("Error loading event:", error);

    const eventDescriptionElement =
      mainEvent.querySelector(".event-description");
    const eventAddressElement = mainEvent.querySelector(".event-address");

    eventDescriptionElement.textContent = " Could not load event details.";
    if (eventAddressElement) {
      eventAddressElement.textContent = "";
    }
  }
}

// Hamburger menu
function initializeHamburgerMenu() {
  const hamburgerMenu = document.getElementById("hamburger-menu");
  const menuOverlay = document.getElementById("menu-overlay");
  const closeMenu = document.getElementById("close-menu");
  const destButtons = document.querySelectorAll(".dest-btn");

  hamburgerMenu.addEventListener("click", () =>
    menuOverlay.classList.add("active")
  );
  closeMenu.addEventListener("click", () =>
    menuOverlay.classList.remove("active")
  );
  menuOverlay.addEventListener("click", (e) => {
    if (e.target === menuOverlay) menuOverlay.classList.remove("active");
  });

  destButtons.forEach((button) => {
    button.addEventListener("click", () => {
      const destinationText = button.querySelector(".dest-text").textContent;
      showNotification(`Opening ${destinationText}...`);
      // Map data-dest or text to actual pages (preserve measures: 800x480)
      const dest =
        button.getAttribute("data-dest") || destinationText.toLowerCase();
      const pageMap = {
        map: "map.html",
        utilities: "utilities.html",
        events: "events.html",
        weather: "weather.html",
        settings: "settings.html",
      };
      const target =
        pageMap[dest] || pageMap[destinationText.toLowerCase()] || "index.html";

      // Close overlay then navigate so users see the notification briefly
      setTimeout(() => {
        menuOverlay.classList.remove("active");
        // Use a short delay before navigation so overlay animation completes
        setTimeout(() => {
          window.location.href = target;
        }, 200);
      }, 600);
    });
  });
}

// Notification
function showNotification(message) {
  const existing = document.querySelector(".notification");
  if (existing) existing.remove();
  const notification = document.createElement("div");
  notification.className = "notification";
  notification.textContent = message;
  notification.style.cssText = `
        position: fixed; top: 80px; left: 50%; transform: translateX(-50%);
        background: #667eea; color: white; padding: 12px 24px;
        border-radius: 25px; font-size: 14px; font-weight: 600;
        box-shadow: 0 4px 20px rgba(102,126,234,0.4); z-index: 2000;
    `;
  document.body.appendChild(notification);
  setTimeout(() => notification.remove(), 3000);
}

// Prevent default touch behaviors
function preventDefaultTouchBehaviors() {
  document.addEventListener(
    "touchend",
    (e) => {
      const now = new Date().getTime();
      if (this.lastTouchEnd && now - this.lastTouchEnd <= 300)
        e.preventDefault();
      this.lastTouchEnd = now;
    },
    false
  );
  document.addEventListener("contextmenu", (e) => e.preventDefault());
  document.addEventListener("selectstart", (e) => e.preventDefault());
  document.addEventListener(
    "touchmove",
    (e) => {
      if (e.touches.length > 1) e.preventDefault();
    },
    { passive: false }
  );
}

// Initialize app
document.addEventListener("DOMContentLoaded", function () {
  initializeMainEvent();
  randomBackground();
  getCurrentLocation();
  initializeHamburgerMenu();
  preventDefaultTouchBehaviors();
});
