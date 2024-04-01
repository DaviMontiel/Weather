import 'package:weather/src/data/models/weather/weather_day.dart';
import 'package:weather/src/data/services/http_service.dart';

class WeatherService extends HttpService {

  final String httpUrl;
  final String token;
  
  WeatherService({
    required this.httpUrl,
    required this.token,
  });


  Future getActualData({
    required String latitude,
    required String longitude,
  }) async {
    final String url = '$httpUrl/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&appid=$token';

    var response = await httpGet(url);

    return WeatherDay.fromApiWeatherMap(response);
  }

  Future getForecasts({
    required String latitude,
    required String longitude,
  }) async {
    final String url = '$httpUrl/data/2.5/forecast?lat=$latitude&lon=$longitude&units=metric&appid=$token';

    var response = await httpGet(url);

    final List forecasts = WeatherDay.fromApiForecastMap(response);

    return forecasts;
  }
}