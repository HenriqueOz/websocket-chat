import 'package:flutter/material.dart';
import 'package:websocket_flutter/app/core/widgets/custom_text_form_field.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';

class HomeServerForm extends StatelessWidget {
  const HomeServerForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Text(
            'Edit the chat server address',
            style: TextStyle(
              color: context.colors.onPrimary,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: context.screenSize.width * .5,
            child: CustomTextFormField(
              label: 'IP',
              hint: 'ex: 192.168.0.0',
              color: context.colors.onPrimary,
              focusColor: context.colors.onPrimary,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: context.screenSize.width * .5,
            child: CustomTextFormField(
              label: 'Port',
              hint: 'ex: 3001',
              color: context.colors.onPrimary,
              focusColor: context.colors.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
