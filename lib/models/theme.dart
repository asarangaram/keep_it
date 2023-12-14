// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:colan_widgets/colan_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorTheme {
  final Color textColor;
  final Color backgroundColor;
  final Color disabledColor;
  final Color overlayBackgroundColor;
  final Color errorColor;
  ColorTheme({
    required this.textColor,
    required this.backgroundColor,
    required this.disabledColor,
    required this.overlayBackgroundColor,
    required this.errorColor,
  });
}

class KeepItTheme {
  ColorTheme colorTheme;
  KeepItTheme({required this.colorTheme});
}

class ThemeNotifier extends StateNotifier<KeepItTheme> {
  ThemeNotifier({required KeepItTheme theme}) : super(theme);
}

final themeProvider = StateNotifierProvider<ThemeNotifier, KeepItTheme>((ref) {
  return ThemeNotifier(
      theme: KeepItTheme(
          colorTheme: ColorTheme(
              textColor: Colors.black,
              backgroundColor: Colors.white.reduceBrightness(0.2),
              disabledColor: Colors.grey.shade300,
              overlayBackgroundColor: Colors.white,
              errorColor: Colors.red)));
});
