import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';

class CustomTextFormField extends StatelessWidget {
  final Color color;
  final Color focusColor;
  final String hint;
  final String label;
  final TextEditingController? controller;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String? value)? validator;

  const CustomTextFormField({
    super.key,
    this.controller,
    required this.color,
    required this.focusColor,
    required this.hint,
    required this.label,
    this.validator,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.textInputType = TextInputType.multiline,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: color,
      ),
      controller: controller,
      validator: validator,
      inputFormatters: inputFormatters,
      keyboardType: textInputType,
      onEditingComplete: () {
        FocusScope.of(context).nextFocus();
      },
      decoration: InputDecoration(
        floatingLabelBehavior: floatingLabelBehavior,
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
