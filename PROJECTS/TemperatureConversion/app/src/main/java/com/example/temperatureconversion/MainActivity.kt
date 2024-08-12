package com.example.temperatureconversion

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Switch
import androidx.compose.material3.Text
import androidx.compose.material3.TextFieldColors
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.focus.focusModifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.em
import androidx.lifecycle.viewmodel.compose.viewModel
import com.example.temperatureconversion.ui.theme.TemperatureConversionTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            TemperatureConversionTheme {
                App()
            }
        }
    }
}
@Composable
fun App(){
    Contents()
}

@Composable
fun Contents(){
     var viewmodel : ViewModelForTempertures = viewModel()

    MainScreen(
        isFahrenheit = viewmodel.isFehrenheit,
        result = viewmodel.convertedTemperture,
        convertTempertature = {viewmodel.calucateConversion(it)},
        toggleSwitch = {viewmodel.toggleSwitch()}
    )
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MainScreen(isFahrenheit: Boolean,
               result: String,
               convertTempertature: (String) -> Unit,
               toggleSwitch: () -> Unit,
) {
    var inputTextState by remember {mutableStateOf("")}

    fun OnTextChange(newText:String){
        inputTextState = newText
    }

    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        modifier = Modifier.fillMaxSize()
    ) {
        Text(
            text = "Temperature Conversion App",
            modifier = Modifier.padding(top = 60.dp, bottom = 40.dp).align(Alignment.CenterHorizontally),
            fontSize = 6.em,
            fontWeight = FontWeight.Bold
        )


        Card(
            colors = CardDefaults.cardColors(Color.White),
            border = BorderStroke(2.dp, Color.Black)
        ) {
            Row(
                modifier = Modifier.padding(16.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                Switch(
                    checked = isFahrenheit, onCheckedChange = { toggleSwitch() },
                    modifier = Modifier.padding(end = 10.dp)
                )//ending switch
                OutlinedTextField(value = inputTextState,
                    onValueChange = {OnTextChange(it) },
                    label = { Text(text = "Enter temperature")},
                    colors = TextFieldDefaults.outlinedTextFieldColors(
                        focusedTextColor = Color.Black,
                    ),
                    modifier = Modifier.padding(16.dp),
                    singleLine = true,
                    trailingIcon ={
                        Text(text = if(!isFahrenheit) "℃" else "℉")
                    },
                    keyboardOptions = KeyboardOptions.Default.copy(keyboardType = KeyboardType.Number)
                )//ending text field
            }//ending row
        }//ending card


        Text(
            text = "The result is: $result",
            modifier = Modifier.padding(top = 50.dp, bottom = 40.dp),
            fontWeight = FontWeight.Bold,
            fontSize = 6.em
        )
        Button(onClick = { convertTempertature(inputTextState) }) {
            Text(text = if(isFahrenheit) "Convert to Celsius" else "Convert to Fahrenheit")
        }
    }
}
