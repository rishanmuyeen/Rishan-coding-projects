package com.example.temperatureconversion

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.ViewModel


//Will handle all the data entered
class ViewModelForTempertures : ViewModel() {
    var isFehrenheit by mutableStateOf(true)
    var convertedTemperature by mutableStateOf("")

    fun toggleSwitch(){
        isFehrenheit = !isFehrenheit
    }
    fun calucateConversion(inputValue:String){
         try{
             val temperture = inputValue.toDouble()
             if(isFehrenheit){
                 convertedTemperature = " %.2f".format((temperture-32)* 5/9)
                 convertedTemperature += "\u2103 "

             }else{
                 convertedTemperature = " %.2f".format((temperture * 9/5) + 32)
                 convertedTemperature += "\u2109 "
             }
         }catch (e : Exception){
             convertedTemperature = "Invaild Input entered!"
         }
    }
}