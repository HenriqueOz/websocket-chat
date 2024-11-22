import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'colors/dark_colors.dart';
part 'colors/light_colors.dart';

class AppTheme {
  final ColorScheme colors;

  AppTheme(this.colors);

  ThemeData get themeData {
    return ThemeData(
      colorScheme: colors,
      scaffoldBackgroundColor: colors.surface,
      textTheme: GoogleFonts.getTextTheme("Poppins"),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.tertiary,
        selectionColor: colors.tertiary,
        selectionHandleColor: colors.tertiary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(colors.onPrimary),
          backgroundColor: WidgetStatePropertyAll(colors.primary),
          overlayColor: WidgetStatePropertyAll(colors.onPrimary.withOpacity(.2)),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
        ),
      ),
    );
  }
}
