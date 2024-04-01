class WeatherDay {

  final double longitude;
  final double latitude;
  final String weather;
  final int weatherCode;
  final double temp;
  final double minTemp;
  final double maxTemp;
  final DateTime? sunrise;
  final DateTime? sunset;
  final String locationName;
  final DateTime dt;

  WeatherDay({
    required this.longitude,
    required this.latitude,
    required this.weather,
    required this.weatherCode,
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
    this.sunrise,
    this.sunset,
    required this.locationName,
    required this.dt,
  });

  factory WeatherDay.fromApiWeatherMap(Map<String, dynamic> map) {
    DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(map['sys']['sunrise'] * 1000, isUtc: true);
    DateTime sunset = DateTime.fromMillisecondsSinceEpoch(map['sys']['sunset'] * 1000, isUtc: true);
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(map['dt'] * 1000, isUtc: true);

    return WeatherDay(
        longitude: map['coord']['lon'],
        latitude: map['coord']['lat'],
        weather: map['weather'][0]['main'],
        weatherCode: map['weather'][0]['id'],
        temp: map['main']['temp'],
        minTemp: double.parse(map['main']['temp_min'].toString()),
        maxTemp: double.parse(map['main']['temp_max'].toString()),
        sunrise: sunrise,
        sunset: sunset,
        locationName: map['name'],
        dt: dt,
      );
  }

  static List<WeatherDay> fromApiForecastMap(Map<String, dynamic> map) {
    double lat = map['city']['coord']['lat'];
    double lon = map['city']['coord']['lon'];
    String name = map['city']['name'];

    final List<WeatherDay> forecasts = [];
    for (var forecast in map['list']) {
      DateTime forecastDt = DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000, isUtc: true);

      WeatherDay weatherDay = WeatherDay(
        longitude: lon,
        latitude: lat,
        weather: forecast['weather'][0]['main'],
        weatherCode: forecast['weather'][0]['id'],
        temp: forecast['main']['temp'],
        minTemp: double.parse(forecast['main']['temp_min'].toString()),
        maxTemp: double.parse(forecast['main']['temp_max'].toString()),
        locationName: name,
        dt: forecastDt,
      );

      forecasts.add( weatherDay );
    }

    return forecasts;
  }
}

// {
//     "coord": {
//         "lon": 1,
//         "lat": 1
//     },
//     "weather": [
//         {
//             "id": 803,
//             "main": "Clouds",
//             "description": "broken clouds",
//             "icon": "04d"
//         }
//     ],
//     "base": "stations",
//     "main": {
//         "temp": 302.39,
//         "feels_like": 307.45,
//         "temp_min": 302.39,
//         "temp_max": 302.39,
//         "pressure": 1009,
//         "humidity": 75,
//         "sea_level": 1009,
//         "grnd_level": 1009
//     },
//     "visibility": 10000,
//     "wind": {
//         "speed": 3.46,
//         "deg": 210,
//         "gust": 3.51
//     },
//     "clouds": {
//         "all": 73
//     },
//     "dt": 1711381971,
//     "sys": {
//         "sunrise": 1711346300,
//         "sunset": 1711389915
//     },
//     "timezone": 0,
//     "id": 0,
//     "name": "",
//     "cod": 200
// }