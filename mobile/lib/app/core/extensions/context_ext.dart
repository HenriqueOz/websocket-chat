import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  ThemeData get theme => Theme.of(this);

  Size get screenSize {
    final Size size = mediaQuery.size;

    if (mediaQuery.orientation == Orientation.landscape) {
      return size.flipped;
    }
    return size;
  }

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get safeAreaSizeWithoutAppBar => _getSafeAreaSize(withoutAppBar: true);

  Size get safeAreaSize => _getSafeAreaSize(withoutAppBar: false);

  Size _getSafeAreaSize({required bool withoutAppBar}) {
    double height = screenSize.height - mediaQuery.padding.bottom - mediaQuery.padding.top;

    if (withoutAppBar) {
      height -= kToolbarHeight;
    }

    Size size = Size(
      screenSize.width,
      height,
    );

    if (mediaQuery.orientation == Orientation.landscape) {
      return size.flipped;
    }

    return size;
  }
}
