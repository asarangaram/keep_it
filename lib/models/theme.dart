import 'package:flutter/material.dart';

Map<String, Color> _colors = {
  "Ivory": const Color.fromARGB(255, 0xFF, 0xFF, 0xFF),
  "Purple": const Color.fromARGB(255, 160, 32, 240),
  "Silver": const Color.fromARGB(255, 192, 192, 192),
};

class CustomThemeData {
  late final TextStyle textStyleBase;

  late final ThemeData themeData;

  late final Color color;

  CustomThemeData() {
    color = _colors["Silver"]!;
    textStyleBase = TextStyle(color: color, fontSize: 32);
    themeData = ThemeData(
        textTheme: TextTheme(
          displayLarge: textStyleBase.copyWith(fontSize: 32),
          displayMedium: textStyleBase.copyWith(fontSize: 31),
          displaySmall: textStyleBase.copyWith(fontSize: 30),
          headlineLarge: textStyleBase.copyWith(fontSize: 29),
          headlineMedium: textStyleBase.copyWith(fontSize: 28),
          headlineSmall: textStyleBase.copyWith(fontSize: 27),
          titleLarge: textStyleBase.copyWith(fontSize: 26),
          titleMedium: textStyleBase.copyWith(fontSize: 24),
          titleSmall: textStyleBase.copyWith(fontSize: 22),
          bodyLarge: textStyleBase.copyWith(fontSize: 20),
          bodyMedium: textStyleBase.copyWith(fontSize: 18),
          bodySmall: textStyleBase.copyWith(fontSize: 16),
          labelLarge: textStyleBase.copyWith(fontSize: 14),
          labelMedium: textStyleBase.copyWith(fontSize: 12),
          labelSmall: textStyleBase.copyWith(fontSize: 10),
        ),
        iconTheme: IconThemeData(color: color, size: 28));
  }
}
