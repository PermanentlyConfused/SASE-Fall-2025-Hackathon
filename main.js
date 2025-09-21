const API_CONFIG = {
  WEATHER_API_KEY: "097a29234019d1584d2e58988bf19873",
};
const GEOCODING_API_KEY = "975dc8a1e9df4b3f968ae19714f8131e";

let currentLocation = {
  address: "",
  coordinates: "",
  lastUpdated: "Just now",
};

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
function getCurrentLocation() {
  updateWeather(44.6698, -74.9813); // updated here
  getTownData(44.6698, -74.9813);
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
function initializeMainEvent() {
  const mainEvent = document.getElementById("main-event");
  if (mainEvent) {
    mainEvent.addEventListener("touchstart", (e) => {
      e.preventDefault();
      mainEvent.style.transform = "scale(0.98)";
    });
    mainEvent.addEventListener("touchend", (e) => {
      e.preventDefault();
      mainEvent.style.transform = "scale(1)";
      showNotification("Casino Night Event selected!");
    });
    mainEvent.addEventListener("click", (e) => {
      e.preventDefault();
      showNotification("Casino Night Event selected!");
    });
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
  getCurrentLocation();
  initializeHamburgerMenu();
  preventDefaultTouchBehaviors();
});
