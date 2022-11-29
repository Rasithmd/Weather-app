// ignore_for_file: non_constant_identifier_names

class Weather {
  String? cityName;
  double? temp;
  double? wind;
  int? humidity;
  double? temp_max;
  String? icon;
  String? weather;

  Weather({
    this.cityName,
    this.temp,
    this.wind,
    this.humidity,
    this.temp_max,
    this.icon,
    this.weather,
  });
  Weather.fromJson(Map<String, dynamic> json) {
    cityName = json["name"];
    temp = json["main"]["temp"];
    wind = json["wind"]["speed"];
    humidity = json["main"]["humidity"];
    temp_max = json["main"]["temp_max"];
    icon = json["weather"][0]["icon"];
    weather = json["weather"][0]["main"];
  }
}
