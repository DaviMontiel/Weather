import 'package:flutter/material.dart';

class ForecastView extends StatelessWidget {
  const ForecastView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [

              Text(
                'Forecasts',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'My_San_Francisco',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              

            ],
          ),
        ),
      ),
    );
  }
}