import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather/src/pages/main_view.dart';

import 'controllers/settings_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(

          // LANG
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],

          // THEME
          // theme: ThemeData(),
          // darkTheme: ThemeData.dark(),
          // themeMode: settingsController.themeMode,

          // WINDOW
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  // case SettingsView.routeName: return const SettingsView();
                  // case SampleItemDetailsView.routeName: return const SampleItemDetailsView();
                  // case SampleItemListView.routeName:

                  default: return const MainPage();
                }
              },
            );
          },
        );
      },
    );
  }
}
