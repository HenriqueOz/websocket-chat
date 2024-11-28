import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';

class CustomTextFormField extends StatelessWidget {
  final Color? color;
  final Color? focusColor;
  final String? hint;
  final String? label;
  final TextEditingController? controller;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String? value)? validator;
  final int? maxLines;
  final bool? isDense;
  final Color fillColor;
  final double borderRadius;

  const CustomTextFormField({
    super.key,
    this.color,
    this.focusColor,
    this.isDense,
    this.hint,
    this.label,
    this.controller,
    this.validator,
    this.inputFormatters,
    this.maxLines,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.textInputType = TextInputType.multiline,
    this.fillColor = Colors.transparent,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: color,
      ),
      enableSuggestions: false,
      maxLines: maxLines,
      controller: controller,
      validator: validator,
      inputFormatters: inputFormatters,
      keyboardType: textInputType,
      onEditingComplete: () {
        FocusScope.of(context).nextFocus();
      },
      decoration: InputDecoration(
        isDense: isDense,
        floatingLabelBehavior: floatingLabelBehavior,
        filled: fillColor != Colors.transparent,
        fillColor: fillColor,
        label: label != null ? Text(label!) : null,
        labelStyle: TextStyle(
          color: color,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: color?.withOpacity(.5),
        ),
        enabledBorder: _defaultBoder(color),
        focusedBorder: _defaultBoder(focusColor),
        errorBorder: _defaultBoder(context.colors.error),
        focusedErrorBorder: _defaultBoder(context.colors.error),
      ),
    );
  }

  InputBorder? _defaultBoder(Color? color) {
    return color != null
        ? OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: BorderSide(
              color: color,
            ))
        : OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ));
  }
}
