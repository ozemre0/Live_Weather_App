import 'package:first_weather_app/notifiers.dart';
import 'package:first_weather_app/weather_Screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkNotifier,
      builder: (context, isDark, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(brightness:isDark ? Brightness.dark : Brightness.light,),
            home: const WeatherScreen());
      },
    );
  }
}

