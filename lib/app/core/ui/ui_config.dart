import 'package:flutter/material.dart';

class UiConfig {
  UiConfig._();
  static String get title => 'Custom Store';
  static ThemeData get theme => ThemeData(
        primaryColor: const Color(0xFFEF9E06),
        scaffoldBackgroundColor: const Color(0xFFDDDCE2),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFEF9E06),
          elevation: 0,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}
