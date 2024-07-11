package com.example.tipcalculator

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.annotation.StringRes
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.safeDrawingPadding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.layout.wrapContentWidth
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Switch
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.example.tipcalculator.ui.theme.TipCalculatorTheme


class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            TipCalculatorTheme {
                TipCalculatorApp()
            }
        }
    }
}
@Composable
fun TipCalculator(){
    var amountInput by remember { mutableStateOf("0") }
    var amount = amountInput.toDoubleOrNull() ?: 0.00
    var tipInput by remember { mutableStateOf("")}
    val tipPercentage = tipInput.toDoubleOrNull() ?: 0.00
    var roundUp by remember { mutableStateOf(false) }
    var tip = tipCalculate(amount = amount,tipPercentage = tipPercentage, roundUp = roundUp)


    Column(modifier = Modifier
        .statusBarsPadding()
        .padding(horizontal = 80.dp)
        .verticalScroll(rememberScrollState())
        .safeDrawingPadding(),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            stringResource(id = R.string.calculateTip), modifier = Modifier
                .padding(bottom = 20.dp, top = 210.dp)
                .align(alignment = Alignment.Start)
        )
        EditNumberField(
            label = R.string.billAmount,
            value = amountInput,
            onValueChange = {amountInput = it},
            modifier = Modifier
                .padding(bottom = 32.dp)
                .fillMaxWidth()
        )
        Spacer(modifier = Modifier.padding(bottom = 32.dp))
        EditNumberField(
            label = R.string.tipPercentage,
            value = tipInput,
            onValueChange ={tipInput = it},
            modifier = Modifier
                .padding(bottom = 32.dp)
                .fillMaxWidth()
            )
        RoundTip(roundUp = roundUp, onRoundChanged = {roundUp = it})
        Spacer(modifier = Modifier.padding(bottom = 32.dp))
        Text(
            stringResource(id = R.string.tipAmount,tip),
            style = MaterialTheme.typography.displaySmall
        )
        Spacer(modifier = Modifier.height(130.dp))
    }
}

private fun tipCalculate(amount:Double,tipPercentage:Double,roundUp:Boolean):String{
    var tip = tipPercentage / 100 * amount
    if(roundUp){
        tip = kotlin.math.ceil(tip)
    }
    return tip.toString()
}
@Composable
fun EditNumberField(
    @StringRes label: Int,
    value: String,
    onValueChange: (String) -> Unit,
    modifier: Modifier = Modifier
) {
    TextField(
        value = value,
        onValueChange = onValueChange,
        singleLine = true,
        label = { Text(stringResource(id = label)) },
        keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number)
    )
}

@Composable
fun RoundTip(roundUp:Boolean,
             onRoundChanged : (Boolean) -> Unit,
             modifier: Modifier = Modifier){
    Row(
        modifier = modifier
            .fillMaxWidth()
            .size(42.dp, 100.dp)
            .padding(top = 25.dp, bottom = 20.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Text(stringResource(id = R.string.roundTIp))
        Switch( modifier = modifier
            .fillMaxWidth()
            .wrapContentWidth(Alignment.End),
            checked = roundUp,
            onCheckedChange = onRoundChanged
        )
    }
}


@Preview (showBackground = true)
@Composable
fun TipCalculatorApp(){
    TipCalculator()
}
