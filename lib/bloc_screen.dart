import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_list.dart';
import 'package:weather_app/share_preferance.dart';

class WeatherListBloc extends ChangeNotifier {
  List<WeatherListModel> _list = [];
  List<WeatherListModel> get list => _list;

  loadData() async {
    var data = await WeatherInfoPreference().getWeatherInfo();
    var jsonData = jsonDecode(data);
    List list = jsonData['Weather'];
    _list = list.map((e) => WeatherListModel.fromMap(e)).toList();
    notifyListeners();
  }
}
