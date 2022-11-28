import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class WeatherInfoPreference {
  static const WEATHER_INFO = "weather_info";
  saveWeatherInfo(var data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        WEATHER_INFO, data.toString().isNotEmpty ? jsonEncode(data) : '');
  }

  Future<dynamic> getWeatherInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(WEATHER_INFO) ?? '';
  }
}
