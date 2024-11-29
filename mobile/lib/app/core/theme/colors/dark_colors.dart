part of '../app_theme.dart';

class DarkColors {
  static ColorScheme get colors => const ColorScheme(
        brightness: Brightness.dark,
        primary: Color.fromARGB(255, 20, 136, 117),
        onPrimary: Color(0xffffffff),
        secondary: Color.fromARGB(255, 40, 168, 177),
        onSecondary: Color(0xff000000),
        tertiary: Color.fromARGB(255, 206, 109, 80),
        onTertiary: Color(0xff000000),
        error: Color(0xffFC1F44),
        onError: Color(0xffFFFFFF),
        surface: Color.fromARGB(255, 61, 61, 61),
        surfaceDim: Color.fromARGB(255, 43, 43, 43),
        surfaceBright: Color.fromARGB(255, 78, 78, 78),
        onSurface: Color(0xffFFFFFF),
        shadow: Color(0xff000000),
      );
}
