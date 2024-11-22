import 'package:flutter/material.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';

class CustomTextFormField extends StatelessWidget {
  final Color color;
  final Color focusColor;
  final String hint;
  final String label;

  const CustomTextFormField({
    super.key,
    required this.color,
    required this.focusColor,
    required this.hint,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: color,
      ),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        label: Text(label),
        labelStyle: TextStyle(
          color: color,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: color.withOpacity(.5),
        ),
        enabledBorder: _defaultBoder(color),
        focusedBorder: _defaultBoder(focusColor),
        errorBorder: _defaultBoder(context.colors.error),
        focusedErrorBorder: _defaultBoder(context.colors.error),
      ),
    );
  }

  InputBorder _defaultBoder(Color color) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: color,
      ),
    );
  }
}
