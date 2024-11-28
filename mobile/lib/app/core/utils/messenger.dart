import 'package:flutter/material.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';

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

  Future<void> showCustomDialog({
    required String title,
    required String description,
    required List<Widget>? actions,
  }) async {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shadowColor: context.colors.shadow,
          backgroundColor: context.colors.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          title: Text(
            title,
            style: TextStyle(color: context.colors.onSurface),
          ),
          content: Text(
            description,
            style: TextStyle(color: context.colors.onSurface),
          ),
          elevation: 10,
          actions: actions,
        );
      },
    );
  }
}
