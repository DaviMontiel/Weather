import 'package:flutter/material.dart';
import 'package:weather/src/data/constants.dart';
import 'package:weather/src/data/models/weather/weather_day.dart';
import 'package:weather/src/data/services/weather_service.dart';

final weatherController = WeatherController();

class WeatherController with ChangeNotifier {
  
  final WeatherService _weatherService = WeatherService(
    httpUrl: Constants.weatherApiUrl,
    token: Constants.weatherApiToken
  );
  late WeatherDay _weatherDay;
  late List<List<WeatherDay>> _forecasts;

  WeatherDay get weatherDay => _weatherDay;
  List<List<WeatherDay>> get forecasts => _forecasts;


  Future<void> fetch() async {
    _weatherDay = await _weatherService.getActualData(
      latitude: '36.711861',
      longitude: '-4.463982',
    );
  
    List<WeatherDay> forecasts = [ _weatherDay ];
    forecasts.addAll(await _weatherService.getForecasts(
      latitude: '36.711861',
      longitude: '-4.463982',
    ));


    _forecasts = _organizeByDay(forecasts);
    
    notifyListeners();
  }

  List<List<WeatherDay>> _organizeByDay(List<WeatherDay> forecasts) {
    Map<DateTime, List<WeatherDay>> result = {};

    // Agrupar las fechas por día
    for (WeatherDay weatherInstance in forecasts) {
      DateTime dt = weatherInstance.dt;
      DateTime dtWithOutHour = DateTime(dt.year, dt.month, dt.day);
      if (!result.containsKey(dtWithOutHour)) {
        result[dtWithOutHour] = [];
      }
      result[dtWithOutHour]!.add(weatherInstance);
    }

    // Convertir el mapa a una lista de listas de Weather
    List<List<WeatherDay>> organizedList = result.values.toList();

    return organizedList;
  }
}