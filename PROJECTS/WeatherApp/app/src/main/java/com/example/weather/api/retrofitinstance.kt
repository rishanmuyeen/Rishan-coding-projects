package com.example.weather.api

import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

object retrofitinstance {
    private const val baseURL = "https://api.weatherapi.com";


     private fun GetInstance() : Retrofit{
          return Retrofit.Builder()
              .baseUrl(baseURL)
              .addConverterFactory(GsonConverterFactory.create())
              .build()
     }

    val weatherApi : WeatherApi = GetInstance().create(WeatherApi::class.java )
}