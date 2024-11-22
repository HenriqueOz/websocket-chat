part of '../app_theme.dart';

class LightColors {
  static ColorScheme get colors => const ColorScheme(
        brightness: Brightness.light,
        primary: Color.fromARGB(255, 35, 182, 125),
        onPrimary: Color(0xffffffff),
        secondary: Color.fromARGB(255, 56, 192, 181),
        onSecondary: Color(0xffffffff),
        tertiary: Color.fromARGB(255, 85, 143, 209),
        onTertiary: Color(0xffffffff),
        error: Color(0xffFC1F44),
        onError: Color(0xffFFFFFF),
        surface: Color(0xffF4FAFB),
        onSurface: Color(0xff000000),
        shadow: Color(0xff000000),
      );
}
