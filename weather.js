const API_KEY = "097a29234019d1584d2e58988bf19873"; // OpenWeather API key

function getWeather(lat, lon) {
  const container = document.getElementById("weather-container");
  const url = `https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&units=metric&appid=${API_KEY}`;

  fetch(url)
    .then((res) => res.json())
    .then((data) => {
      const temperature = Math.round(data.main?.temp ?? 25);
      const condition = data.weather?.[0]?.description ?? "Clear";
      const humidity = data.main?.humidity ?? 50;

      container.innerHTML = `
                <div class="weather-card">
                    <span class="weather-icon">☀️</span>
                    <div class="weather-info">
                        <h2>Current Weather</h2>
                        <span>Temperature: ${temperature}°C</span>
                        <span>Condition: ${condition}</span>
                        <span>Humidity: ${humidity}%</span>
                    </div>
                </div>
            `;
    })
    .catch((err) => {
      console.error("Weather API error:", err);
      container.innerHTML = `
                <div class="weather-card">
                    <span class="weather-icon">☀️</span>
                    <div class="weather-info">
                        <h2>Current Weather</h2>
                        <span>Temperature: 25°C</span>
                        <span>Condition: Clear</span>
                        <span>Humidity: 40%</span>
                    </div>
                </div>
            `;
    });
}

function getCurrentLocationWeather() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      (position) => {
        getWeather(position.coords.latitude, position.coords.longitude);
      },
      (error) => {
        console.error("Error getting location:", error);
        getWeather(44.662, -75.468);
      },
      { enableHighAccuracy: true, timeout: 10000 }
    );
  } else {
    getWeather(44.662, -75.468); // default: Potsdam
  }
}

document.addEventListener("DOMContentLoaded", getCurrentLocationWeather);
