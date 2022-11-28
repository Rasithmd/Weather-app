import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/share_preferance.dart';

class WeatherApiClient {
  Future<Weather>? getCurrentWeather(String? location) async {
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=90c878506c4812802ac65ebe6ca9edf4&units=metric");
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    if (response != null) {
      WeatherInfoPreference().saveWeatherInfo(response);
    }
    print(Weather.fromJson(body).cityName);
    return Weather.fromJson(body);
  }
}
