import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:websocket_flutter/app/core/widgets/custom_text_form_field.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';

class HomeServerForm extends StatefulWidget {
  const HomeServerForm({super.key});

  @override
  State<HomeServerForm> createState() => _HomeServerFormState();
}

class _HomeServerFormState extends State<HomeServerForm> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

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
              hint: 'ex: 192.168.0.1',
              color: context.colors.onPrimary,
              focusColor: context.colors.onPrimary,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              textInputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                LengthLimitingTextInputFormatter(15),
              ],
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
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              textInputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
