import 'package:flutter/material.dart';

class ButtonThemes extends ThemeExtension<ButtonThemes> {
  final ColorScheme colors;

  ButtonThemes({required this.colors});

  ButtonStyle get primaryButton => ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(colors.primary),
        foregroundColor: WidgetStatePropertyAll(colors.onPrimary),
      );

  ButtonStyle get secondaryButton => ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(colors.secondary),
        foregroundColor: WidgetStatePropertyAll(colors.onSecondary),
      );

  ButtonStyle get tertirayButton => ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(colors.tertiary),
        foregroundColor: WidgetStatePropertyAll(colors.onTertiary),
      );

  ButtonStyle get errorButton => ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(colors.error),
        foregroundColor: WidgetStatePropertyAll(colors.onError),
      );

  @override
  ThemeExtension<ButtonThemes> copyWith({ColorScheme? colors}) {
    return ButtonThemes(
      colors: colors ?? this.colors,
    );
  }

  @override
  ThemeExtension<ButtonThemes> lerp(covariant ThemeExtension<ThemeExtension>? other, double t) {
    return ButtonThemes(colors: colors);
  }
}
