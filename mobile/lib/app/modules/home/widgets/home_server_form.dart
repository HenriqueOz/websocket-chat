import 'package:flutter/material.dart';
import 'package:websocket_flutter/app/core/custom_text_form_field.dart';

class HomeServerForm extends StatelessWidget {
  const HomeServerForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Form(
      child: Column(
        children: [
          Text('ajdklas alk sdlajdlkas'),
          CustomTextFormField(),
          CustomTextFormField(),
        ],
      ),
    );
  }
}
