import 'package:flutter/material.dart';

class Messenger {
  final BuildContext context;

  Messenger._(this.context);

  static Messenger of(BuildContext context) {
    return Messenger._(context);
  }

  void showSnackbar({required String message, Color? backgroundColor, Color? textColor}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: textColor,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
