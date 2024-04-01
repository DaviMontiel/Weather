import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather/src/controllers/weather_controller.dart';
import 'package:weather/src/data/models/weather/weather_day.dart';
import 'package:weather/src/pages/day_view.dart';
import 'package:weather/src/pages/forecast_view.dart';

class MainPage extends StatefulWidget {

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // late PageController _pageController;
  // double _opacity = 0.0;

  // @override
  // void initState() {
  //   super.initState();
  //   _pageController = PageController(initialPage: 1);
  //   _pageController.addListener(_onPageViewScroll);
  // }

  // @override
  // void dispose() {
  //   _pageController.removeListener(_onPageViewScroll);
  //   _pageController.dispose();
  //   super.dispose();
  // }

  // void _onPageViewScroll() {
  //   setState(() {
  //     if (_pageController.page! < 1) {
  //     _opacity = 1 - _pageController.page!;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    bool isFirstDay = true;

    List<Widget> pages = [];
    for (List days in weatherController.forecasts) {
      var view = DayView( weatherDay: days[0], currentDay: isFirstDay );

      pages.add(view);

      isFirstDay = false;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [

          // const DayView(),

          // Positioned.fill(
          //   child: Opacity(
          //     opacity: _opacity,
          //     child: Transform.translate(
          //       offset: Offset(0.0, MediaQuery.of(context).size.height * (1 - _opacity) * -0.1),
          //       child: const ForecastView(),
          //     ),
          //   ),
          // ),

          PageView(
            scrollDirection: Axis.horizontal,
            children: [
              PageView(
                scrollDirection: Axis.vertical,
                children: [

                  for (Widget days in pages)
                    days,

                ],
              ),
              const ForecastView(),
            ],
          ),

        ],
      ),
    );
  }
}