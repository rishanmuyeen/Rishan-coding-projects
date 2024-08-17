package com.example.weather

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.LocationOn
import androidx.compose.material.icons.filled.Search
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.livedata.observeAsState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.VerticalAlignmentLine
import androidx.compose.ui.platform.LocalSoftwareKeyboardController
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import coil.compose.AsyncImage
import com.example.weather.Gemini.GeminiViewModel
import com.example.weather.api.NetworkResponse
import com.example.weather.apiData.WeatherModel

@Composable
fun WeatherPage(
    weatherViewModel: WeatherViewModel = WeatherViewModel(), // Initialize WeatherViewModel
    geminiViewModel: GeminiViewModel = GeminiViewModel() // Initialize GeminiViewModel
) {
    var city by remember { mutableStateOf("") } // State for storing the city input
    val keyboardController = LocalSoftwareKeyboardController.current

    val weatherResult = weatherViewModel.weatherResponse.observeAsState() // Observe weather response
    val aiResponse by geminiViewModel.aiResponse.observeAsState("") // Observe AI response
    val isloading = geminiViewModel.isloading.observeAsState()

    LazyColumn(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
            .fillMaxSize()   // Makes the Surface fill the entire screen
            .background(Color.hsl(209f, 0.51f, 0.50f, 0.93f)), // Sets the background color to Light Gray,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        item { Text(text = "Check the Weather", fontWeight = FontWeight.Bold, fontSize = 32.sp, modifier = Modifier.padding(top = 35.dp))}
        item {
            // Input field for city and search button
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(top = 30.dp, bottom = 20.dp, start = 15.dp),
                verticalAlignment = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.SpaceEvenly
            ) {
                OutlinedTextField(
                    value = city,
                    onValueChange = { city = it },
                    label = { Text(text = "Enter your city") },
                    modifier = Modifier.weight(1f),
                    singleLine = true,
                    textStyle = TextStyle(color = Color.Black)
                )
                IconButton(
                    onClick = {
                        weatherViewModel.getData(city)
                        keyboardController?.hide()
                    }
                ) {
                    Icon(
                        imageVector = Icons.Default.Search,
                        contentDescription = "Search the city"
                    )
                }
            }
        }

        // Display weather information or loading/error states
        item {
            when (val result = weatherResult.value) {
                is NetworkResponse.Error -> {
                    Text(text = result.message)
                }
                NetworkResponse.Loading -> {
                    CircularProgressIndicator()
                }
                is NetworkResponse.Success -> {
                    WeatherDisplay(result.data)
                    val summaryData = getDataForSummary(result.data)
                    Summary(geminiViewModel, summaryData) // Call Summary composable with summary data
                }
                null -> {
                    Text(text = "Enter a city name!\nTo load the information",
                        modifier = Modifier.fillMaxWidth(),
                        textAlign = TextAlign.Center
                    )
                }
            }
        }

        // Spacer to add some space before displaying AI response
        item {
            Spacer(modifier = Modifier.height(20.dp))
        }

        // Display AI response if available
        item {
            if(isloading.value == true){
                CircularProgressIndicator()
            }
            else if (aiResponse.isNotEmpty()) {
                Card(
                    modifier = Modifier.padding(16.dp),
                ) {
                    Text(
                        text = aiResponse,
                        fontSize = 18.sp,
                        modifier = Modifier.padding(16.dp),
                        textAlign = TextAlign.Center
                    )
                }
            }
        }
    }
}

@Composable
fun Summary(viewModel: GeminiViewModel, data: String) {
    LaunchedEffect(data) {
        viewModel.sendMessage(data) // Send message to AI with weather summary data
    }
}

@Composable
fun WeatherKeyValue(key: String, value: String) {
    Column(
        modifier = Modifier.padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(text = value, fontWeight = FontWeight.Bold, fontSize = 24.sp)
        Text(text = key, fontWeight = FontWeight.SemiBold, color = Color.Gray)
    }
}

@Composable
fun WeatherDisplay(data: WeatherModel) {
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 10.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        // Display location information
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(10.dp),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.Center
        ) {
            Icon(
                imageVector = Icons.Default.LocationOn,
                contentDescription = "Location icon"
            )
            Text(text = data.location.name)
            Spacer(modifier = Modifier.width(20.dp))
            Text(text = data.location.country)
        }
        Spacer(modifier = Modifier.height(20.dp))

        // Display temperature
        Text(
            text = "${data.current.temp_c} °C",
            fontSize = 56.sp,
            fontWeight = FontWeight.Bold,
            textAlign = TextAlign.Center
        )

        // Display weather condition image
        AsyncImage(
            modifier = Modifier
                .size(160.dp)
                .padding(top = 20.dp),
            model = "https:${data.current.condition.icon}".replace("64x64", "128x128"),
            contentDescription = "Image of the weather"
        )

        // Display weather condition text
        Text(
            text = data.current.condition.text,
            fontSize = 20.sp,
            color = Color.White,
            fontWeight = FontWeight.Bold,
            textAlign = TextAlign.Center
        )
        Spacer(modifier = Modifier.height(20.dp))

        // Display additional weather information
        Card {
            Column(
                verticalArrangement = Arrangement.SpaceEvenly,
                horizontalAlignment = Alignment.CenterHorizontally,
                modifier = Modifier.fillMaxWidth()
            ) {
                Row {
                    WeatherKeyValue(key = "Humidity", value = data.current.humidity.toString())
                    WeatherKeyValue(key = "Wind Speed", value = data.current.wind_kph.toString())
                }
                Row {
                    WeatherKeyValue(key = "UV", value = data.current.uv.toString())
                    WeatherKeyValue(key = "Pressure", value = data.current.pressure_mb.toString())
                }
            }
        }
    }
}

// Generate summary data string for AI from weather model
@Composable
fun getDataForSummary(data: WeatherModel): String {
    return "The humidity is ${data.current.humidity}, the wind speed is ${data.current.wind_kph}, the UV index is ${data.current.uv}, and the pressure is ${data.current.pressure_mb}. The city is ${data.location.name} from the country of ${data.location.country}."
}
