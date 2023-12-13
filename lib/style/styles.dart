import 'package:flutter/material.dart';

import 'custom_color.dart';
import 'text_theme.dart';

class StyleResource {
  final Brightness brightness;
  final ThemeData themeData;
  final TextThemeResource textThemeResource;

  StyleResource(this.brightness)
      : themeData = _getTheme(brightness),
        textThemeResource = TextThemeResource(brightness);
  static ThemeData _getTheme(Brightness brightness) {
    MaterialColor materialColor = CustomColor(47, 215, 245).materialColor;

    TextThemeResource textThemeResource = TextThemeResource(brightness);
    return ThemeData(
      //colorSchemeSeed: CustomColor(0xDB, 0xFE, 0xFD).materialColor,
      primarySwatch: materialColor,
      brightness: brightness,
      textTheme: textThemeResource.textTheme,
      appBarTheme: AppBarTheme(
        titleTextStyle: textThemeResource.textTheme.headlineLarge,
        foregroundColor: textThemeResource.textColor,
        backgroundColor: (brightness == Brightness.dark)
            ? CustomColor(44, 41, 33).materialColor.shade200
            : CustomColor(47, 215, 245).materialColor.shade900,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0,
          iconSize: 12,
          extendedTextStyle: textThemeResource.textTheme.bodySmall),
      buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
            foregroundColor:
                MaterialStateProperty.all<Color>(textThemeResource.textColor)),
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.all(2),

        //dense: true,
        iconColor: textThemeResource.textColor,
        textColor: textThemeResource.textColor,
        style: ListTileStyle.drawer,
        selectedTileColor: (brightness == Brightness.dark)
            ? const Color.fromARGB(0xFF, 48 + 50, 48 + 50, 48 + 50)
            : Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10))),
      ),

      iconTheme: IconThemeData(color: textThemeResource.textColor, size: 26),
    );
  }
}
