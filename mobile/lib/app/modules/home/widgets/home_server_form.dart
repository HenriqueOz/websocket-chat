import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_flutter/app/core/strings/strings.dart';
import 'package:websocket_flutter/app/core/utils/validator.dart';
import 'package:websocket_flutter/app/core/widgets/custom_text_form_field.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';
import 'package:websocket_flutter/app/modules/home/bloc/home_form_bloc.dart';

class HomeServerForm extends StatefulWidget {
  const HomeServerForm({super.key});

  @override
  State<HomeServerForm> createState() => _HomeServerFormState();
}

class _HomeServerFormState extends State<HomeServerForm> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<HomeFormBloc>().add(HomeFormAddFormState(formState: _formState));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formState,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          Text(
            Strings.homeServerFormDescription,
            style: TextStyle(
              color: context.colors.onPrimary,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: context.screenSize.width * .5,
            child: CustomTextFormField(
              label: Strings.homeIpFieldLabel,
              hint: Strings.homeIpFieldHint,
              color: context.colors.onPrimary,
              focusColor: context.colors.onPrimary,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              textInputType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return Strings.formCantBeEmpty;
                }

                if (!Validator.validateIPv4(value)) {
                  return Strings.homeInvalidIp;
                }

                return null;
              },
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
              label: Strings.homePortFieldLabel,
              hint: Strings.homePortFieldHint,
              color: context.colors.onPrimary,
              focusColor: context.colors.onPrimary,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              textInputType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return Strings.formCantBeEmpty;
                }

                if (!Validator.validatePort(value)) {
                  return Strings.homeInvalidPort;
                }

                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
