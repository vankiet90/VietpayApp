import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light =>
      ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue);

  static ThemeData get dark => ThemeData.dark(useMaterial3: true);
}
