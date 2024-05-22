const weatherForm = document.querySelector(".weatherForm");
const cityInput = document.querySelector(".cityInput");
const card = document.querySelector(".card");

const APIkey = "6034285729d97a05f09c4bed63aa36a6";

weatherForm.addEventListener("submit", async event => {
    event.preventDefault();
    const city = cityInput.value;
    if (city) {
        try {
            const weatherData = await getWeatherData(city);
            displayWeatherInfo(weatherData);
        } catch (error) {
            displayError(error.message);
        }
    } else {
        displayError("Please enter a city");
    }
});

async function getWeatherData(city) {
    const apiURL = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${APIkey}&units=metric`;
    const response = await fetch(apiURL);
    if (!response.ok) {
        throw new Error("Couldn't find the weather data!");
    }
    return await response.json();
}

function displayWeatherInfo(data) {
    const {
        name: city,
        main: { temp, humidity },
        weather: [{ description, id }]
    } = data;

    card.textContent = "";
    card.style.display = "flex";
    card.style.flexDirection = "column";
    card.style.alignItems = "center";
    card.style.justifyContent = "center";

    const cityName = document.createElement("h2");
    cityName.textContent = city;
    
    const temperature = document.createElement("p");
    temperature.textContent = `Temperature: ${temp}°C`;
    
    const weatherDescription = document.createElement("p");
    weatherDescription.textContent = `Weather: ${description}`;
    
    const humidityInfo = document.createElement("p");
    humidityInfo.textContent = `Humidity: ${humidity}%`;

    const weatherEmoji = document.createElement("p");
    weatherEmoji.textContent = getWeatherEmoji(id);

    card.appendChild(cityName);
    card.appendChild(temperature);
    card.appendChild(weatherDescription);
    card.appendChild(humidityInfo);
    card.appendChild(weatherEmoji);
}

function getWeatherEmoji(weatherID) {
    if (weatherID >= 200 && weatherID < 300) {
        return "⛈️"; // Thunderstorm
    } else if (weatherID >= 300 && weatherID < 500) {
        return "🌦️"; // Drizzle
    } else if (weatherID >= 500 && weatherID < 600) {
        return "🌧️"; // Rain
    } else if (weatherID >= 600 && weatherID < 700) {
        return "❄️"; // Snow
    } else if (weatherID >= 700 && weatherID < 800) {
        return "🌫️"; // Atmosphere (fog, mist, etc.)
    } else if (weatherID === 800) {
        return "☀️"; // Clear
    } else if (weatherID > 800) {
        return "☁️"; // Clouds
    } else {
        return "❓"; // Unknown
    }
}

function displayError(message) {
    const errorDisplay = document.createElement("p");
    errorDisplay.textContent = message;
    errorDisplay.classList.add("errorDisplay");

    card.textContent = "";
    card.style.display = "flex";
    card.appendChild(errorDisplay);
}

// adding a clock 
function updateClock(){
    const now = new Date();
    let hours = now.getHours();
    const meridiem = hours>=12 ? "PM" : "AM";
    hours = hours % 12 || 12;
    hours = hours.toString().padStart(2,0);
    const min = now.getMinutes().toString().padStart(2,0);
    const sec = now.getSeconds().toString().padStart(2,0);
    const timeString = `${hours}:${min}:${sec} ${meridiem}`;
    document.getElementById("clock").textContent = timeString;
}

updateClock();
setInterval(updateClock, 1000);