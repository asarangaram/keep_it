import 'package:flutter/material.dart';

class TextSize {
  static const double offset = 4;
  double ll = 24 - offset;
  double mm = 22 - offset;
  double ss = 20 - offset;

  double ll2 = 18 - offset;
  double mm2 = 16 - offset;
  double ss2 = 14 - offset;

  FontWeight display = FontWeight.w700;
  FontWeight headline = FontWeight.w700;
  FontWeight title = FontWeight.w400;
  FontWeight body = FontWeight.w400;
  FontWeight label = FontWeight.w300;

  TextStyle style = const TextStyle(
    fontFamily: 'Kalam',
    inherit: false,
    textBaseline: TextBaseline.ideographic,
  );

  TextStyle get({required double fontSize, required FontWeight fontWeight}) =>
      style.copyWith(fontSize: fontSize, fontWeight: fontWeight);

  late TextStyle displayLarge;
  late TextStyle displayMedium;
  late TextStyle displaySmall;

  late TextStyle headlineLarge;
  late TextStyle headlineMedium;
  late TextStyle headlineSmall;

  late TextStyle titleLarge;
  late TextStyle titleMedium;
  late TextStyle titleSmall;

  late TextStyle bodyLarge;
  late TextStyle bodyMedium;
  late TextStyle bodySmall;

  late TextStyle labelLarge;
  late TextStyle labelMedium;
  late TextStyle labelSmall;

  TextSize() {
    displayLarge = get(fontSize: ll + 4, fontWeight: display);
    displayMedium = get(fontSize: mm + 4, fontWeight: display);
    displaySmall = get(fontSize: ss + 4, fontWeight: display);

    headlineLarge = get(fontSize: ll, fontWeight: headline);
    headlineMedium = get(fontSize: mm, fontWeight: headline);
    headlineSmall = get(fontSize: ss, fontWeight: headline);

    titleLarge = get(fontSize: ll, fontWeight: title);
    titleMedium = get(fontSize: mm, fontWeight: title);
    titleSmall = get(fontSize: ss, fontWeight: title);

    bodyLarge = get(fontSize: ll, fontWeight: body);
    bodyMedium = get(fontSize: mm, fontWeight: body);
    bodySmall = get(fontSize: ss, fontWeight: body);

    labelLarge = get(fontSize: ll2, fontWeight: label);
    labelMedium = get(fontSize: mm2, fontWeight: label);
    labelSmall = get(fontSize: ss2, fontWeight: label);
  }
}

class TextThemeResource extends TextSize {
  Brightness brightness;

  late final TextTheme textTheme;

  Color get textColor => (brightness == Brightness.dark)
      ? const Color.fromARGB(255, 255, 255, 255)
      : const Color.fromARGB(255, 0, 0, 0);

  Color get textBackgroundColor =>
      (brightness == Brightness.dark) ? Colors.black87 : Colors.white;

  TextThemeResource(this.brightness) {
    textTheme = TextTheme(
      displayLarge: displayLarge.copyWith(color: textColor),
      displayMedium: displayMedium.copyWith(color: textColor),
      displaySmall: displaySmall.copyWith(color: textColor),
      headlineLarge: headlineLarge.copyWith(color: textColor),
      headlineMedium: headlineMedium.copyWith(color: textColor),
      headlineSmall: headlineSmall.copyWith(color: textColor),
      titleLarge: titleLarge.copyWith(color: textColor),
      titleMedium: titleMedium.copyWith(color: textColor),
      titleSmall: titleSmall.copyWith(color: textColor),
      bodyLarge: bodyLarge.copyWith(color: textColor),
      bodyMedium: bodyMedium.copyWith(color: textColor),
      bodySmall: bodySmall.copyWith(color: textColor),
      labelLarge: labelLarge.copyWith(color: textColor),
      labelMedium: labelMedium.copyWith(color: textColor),
      labelSmall: labelSmall.copyWith(color: textColor),
    );
  }
}
