import 'dart:developer';

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

  Size get safeAreaSize {
    final Size size = Size(
      screenSize.width,
      screenSize.height - mediaQuery.padding.bottom - mediaQuery.padding.top - kToolbarHeight,
    );

    log(mediaQuery.orientation.toString());

    if (mediaQuery.orientation == Orientation.landscape) {
      return size.flipped;
    }
    return size;
  }
}
