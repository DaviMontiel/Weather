import 'dart:ui';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'package:weather/src/data/models/weather/weather_day.dart';

class DayView extends StatelessWidget {

  final WeatherDay weatherDay;
  final bool currentDay;

  const DayView({
    super.key,
    required this.weatherDay,
    this.currentDay = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          
          ...(currentDay
            ? _background()
            : _background2(
                color: _getDayStatusColor(weatherDay.weatherCode)
              )
            ),
      
          _front(),
      
        ],
      )
    );
  }//WID

  List<Widget> _background() {
    return [
      // COLORS
      Align(
        alignment: const AlignmentDirectional(1.8, -0.15),
        child: Container(
          width: 300,
          height: 300,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.deepPurple
          ),
        ),
      ),
      Align(
        alignment: const AlignmentDirectional(-1.8, -0.15),
        child: Container(
          width: 300,
          height: 300,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.deepPurple
          ),
        ),
      ),
      Align(
        alignment: const AlignmentDirectional(0, -1),
        child: Container(
          width: 300,
          height: 300,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 253, 178, 79)
          ),
        ),
      ),

      // BLUR
      ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
        ),
      ),
    ];
  }//WID

  List<Widget> _background2({required Color color}) {
    return [
      // COLORS
      Align(
        alignment: const AlignmentDirectional(0, -0.4),
        child: Container(
          width: 275,
          height: 275,
          decoration: BoxDecoration(
            color: color
          ),
        ),
      ),

      // BLUR
      ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
        ),
      ),
    ];
  }//WID

  Widget _front() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Builder(
          builder: (context) {
            String dayName = DateFormat('EEEE', 'es').format(weatherDay.dt);
            String firstDayNameCharacter = dayName.substring(0, 1).toUpperCase();
            String lastDayNameCharacters = dayName.substring(1).toLowerCase();
            String weekDayName = firstDayNameCharacter + lastDayNameCharacters;
            String dayTime;

            if (currentDay) {
              dayTime = '$weekDayName ${DateFormat('dd • H:mm a').format(weatherDay.dt).toLowerCase()}';
            } else {
              dayTime = '$weekDayName ${DateFormat('dd').format(weatherDay.dt).toLowerCase()}';
            }

            // API DATA
            String temp = weatherDay.temp.toString().split('.')[0];
            String minTemp = weatherDay.minTemp.toString();
            String maxTemp = weatherDay.maxTemp.toString();
            String locationName = weatherDay.locationName;

            Map dailyInfo = {
              'minTemp': minTemp,
              'maxTemp': maxTemp,
              'dtSunrise': weatherDay.sunrise,
              'dtSunset': weatherDay.sunset,
            };

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  '📍 $locationName',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'My_San_Francisco',
                    color: Colors.white70,
                  ),
                ),

                const SizedBox( height: 8 ),

                Text(
                  'Good Morning',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'My_San_Francisco',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                Column(
                  children: [
                    Image.asset('assets/images/${_getDayStatusImageName(weatherDay.weatherCode)}'),

                    Text(
                      '$tempºC',
                      style: TextStyle(
                        fontSize: 45,
                        fontFamily: 'My_San_Francisco',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    Text(
                      weatherDay.weather.toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'My_San_Francisco',
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox( height: 8 ),

                    Text(
                      dayTime,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'My_San_Francisco',
                        color: Colors.white54,
                      ),
                    ),

                    const SizedBox( height: 30 ),

                    _showDailyInfo(dailyInfo),

                  ],
                ),
              ],
            );
          }
        ),
      ),
    );
  }//WID

  Widget _showDailyInfo(Map dailyInfo) {
    return Column(
      children: [

        if (dailyInfo['dtSunrise'] != null)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            _showDailyInfoItem(
              img: 'assets/images/11.png',
              secction: 'Sunrise',
              value: DateFormat('H:mm a').format(dailyInfo['dtSunrise']).toLowerCase(),
            ),
            _showDailyInfoItem(
              img: 'assets/images/12.png',
              secction: 'Sunset',
              value: DateFormat('H:mm a').format(dailyInfo['dtSunset']).toLowerCase(),
            ),

          ],
        ),

        const SizedBox( height: 24 ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            _showDailyInfoItem(
              img: 'assets/images/13.png',
              secction: 'Temp Max',
              value: '${dailyInfo['maxTemp']}ºC'
            ),
            _showDailyInfoItem(
              img: 'assets/images/14.png',
              secction: 'Temp Min',
              value: '${dailyInfo['minTemp']}ºC'
            ),

          ],
        ),

      ],
    );
  }//WID

  Widget _showDailyInfoItem({required String img, required String secction, required String value}) {
    return Row(
      children: [
        Image.asset(
          img,
          width: 60,
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              secction,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'My_San_Francisco',
                color: Colors.white54,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'My_San_Francisco',
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    );
  }//WID

  String _getDayStatusImageName(int weatherCode) {
    switch (weatherCode) {
		  case >= 200 && < 300 : return '1.png';
			case >= 300 && < 400 : return '2.png';
			case >= 500 && < 600 : return '3.png';
			case >= 600 && < 700 : return '4.png';
			case >= 700 && < 800 : return '5.png';
			case == 800 : return '6.png';
			case > 800 && <= 804 : return '7.png';

		  default: return '7.png';
    }
  }

  Color _getDayStatusColor(int weatherCode) {
    switch (weatherCode) {
		  case >= 200 && < 300 : return const Color.fromARGB(255, 253, 178, 79);
			case >= 300 && < 400 : return const Color.fromARGB(255, 253, 178, 79);
			case >= 500 && < 600 : return const Color.fromARGB(255, 79, 160, 253);
			case >= 600 && < 700 : return const Color.fromARGB(255, 253, 178, 79);
			case >= 700 && < 800 : return const Color.fromARGB(255, 253, 178, 79);
			case == 800 : return const Color.fromARGB(255, 253, 178, 79);
			case > 800 && <= 804 : return const Color.fromARGB(255, 253, 178, 79);

		  default: return const Color.fromARGB(255, 253, 178, 79);
    }
  }
}