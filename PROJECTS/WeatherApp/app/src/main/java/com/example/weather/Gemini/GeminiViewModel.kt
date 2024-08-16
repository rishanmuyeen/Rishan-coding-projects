package com.example.weather.Gemini

import android.util.Log
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.google.ai.client.generativeai.GenerativeModel
import kotlinx.coroutines.launch

class GeminiViewModel : ViewModel() {
    private val _aiResponse = MutableLiveData<String>()
    val aiResponse: LiveData<String> = _aiResponse

    val generativeAI: GenerativeModel = GenerativeModel(
        modelName = "gemini-pro",
        apiKey = "AIzaSyCHlbS7nR11PjJWgd_3i97lAOMKO-hPThg"
    )

    fun sendMessage(result: String) {
        viewModelScope.launch {
            try {
                val chat = generativeAI.startChat()
                val response = chat.sendMessage(result+". Now make a paragraph describing the weather, and some kind of prediction for the future too also make it short like in points ")
                _aiResponse.value = response.text
                Log.i("SendMessage", "Response from: ${response.text}")
            } catch (e: Exception) {
                Log.e("SendMessage", "Error: ${e.message}")
            }
        }
    }
}
