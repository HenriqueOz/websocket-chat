import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'dark_colors.dart';
part 'light_colors.dart';

class AppTheme {
  final ColorScheme colors;

  AppTheme(this.colors);

  ThemeData get themeData {
    return ThemeData(
      colorScheme: colors,
      scaffoldBackgroundColor: colors.surface,
      textTheme: GoogleFonts.getTextTheme("Poppins"),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.primary,
        selectionColor: colors.primary,
        selectionHandleColor: colors.primary,
      ),
    );
  }
}
