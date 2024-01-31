// import 'package:flutter/material.dart';

// class ThemeSwitcher extends StatefulWidget {
//   const ThemeSwitcher({super.key});

//   @override
//   State<ThemeSwitcher> createState() => _ThemeSwitcherState();
// }

// class _ThemeSwitcherState extends State<ThemeSwitcher> {
//    bool _isDarkMode = false;

//   ThemeData _lightTheme = ThemeData(
//     brightness: Brightness.light,
//     primaryColor: Colors.blue,
//   );

//   ThemeData _darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     primaryColor: Colors.indigo,
//   );
//   @override
  
//   Widget build(BuildContext context) {
//       final currentTheme = _isDarkMode ? _darkTheme : _lightTheme;

//     return Theme(data: currentTheme, child: Scaffold(body: currentTheme,)) ;
//   }
// }