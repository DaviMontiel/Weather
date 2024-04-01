import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather/src/controllers/weather_controller.dart';

import 'src/app.dart';
import 'src/controllers/settings_controller.dart';

void main() async {
  // INIT FLUTTER SERVICES
  WidgetsFlutterBinding.ensureInitialized();

  // UP BAR TRANSPARENT
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  // INIT CONSTROLLERS
  await weatherController.fetch();
  await settingsController.loadSettings();

  // RUN APP
  runApp( const MyApp() );
}