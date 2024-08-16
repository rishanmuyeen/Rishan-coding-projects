package com.example.weather

import android.util.Log
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.weather.api.Constants
import com.example.weather.api.NetworkResponse
import com.example.weather.api.retrofitinstance
import com.example.weather.apiData.WeatherModel
import kotlinx.coroutines.launch

class WeatherViewModel : ViewModel() {
    private val weatherApi = retrofitinstance.weatherApi
    private val _weatherResult = MutableLiveData<NetworkResponse<WeatherModel>>()
    val weatherResponse  : LiveData<NetworkResponse<WeatherModel>> = _weatherResult

    fun getData(city:String){
        _weatherResult.value = NetworkResponse.Loading
        viewModelScope.launch {
            try {
                val respnse = weatherApi.getApi(Constants.apiKey,city)
                if(respnse.isSuccessful){
                    respnse.body()?.let {
                        _weatherResult.value = NetworkResponse.Success(it)
                    }
                }else{
                    _weatherResult.value = NetworkResponse.Error("Failed to fetch the data!")
                }
            }catch (e : Exception){
                _weatherResult.value = NetworkResponse.Error(e.message.toString())
            }

        }
    }
}