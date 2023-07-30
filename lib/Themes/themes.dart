import 'package:flutter/material.dart';

class CustomTheme{
  static const Color primaryColor = Color.fromRGBO(63, 81, 181, 1);
  static const Color secondaryColor = Colors.orange;

  static final mainTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: primaryColor
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          elevation: 0,
        ),
  );
}