import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:websocket_flutter/app/core/utils/validator.dart';
import 'package:websocket_flutter/app/core/widgets/custom_text_form_field.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';
import 'package:websocket_flutter/app/modules/home/bloc/home_form_bloc.dart';

class HomeServerForm extends StatefulWidget {
  const HomeServerForm({
    super.key,
  });

  @override
  State<HomeServerForm> createState() => _HomeServerFormState();
}

class _HomeServerFormState extends State<HomeServerForm> {
  final TextEditingController _ipFieldEC = TextEditingController();
  final TextEditingController _portFieldEC = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  void dispose() {
    _ipFieldEC.dispose();
    _portFieldEC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<HomeFormBloc>().add(HomeFormAddFormState(formState: _formState));
    context.read<HomeFormBloc>().add(
          HomeFormAddController(
            controller: _ipFieldEC,
            key: 'ip_controller',
          ),
        );
    context.read<HomeFormBloc>().add(
          HomeFormAddController(
            controller: _portFieldEC,
            key: 'port_controller',
          ),
        );
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
            context.strings["home"]?["serverFormDescription"] ?? '',
            style: TextStyle(
              color: context.colors.onPrimary,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: context.screenSize.width * .5,
            child: CustomTextFormField(
              maxLines: 1,
              controller: _ipFieldEC,
              label: context.strings["home"]?["ipFieldLabel"],
              hint: context.strings["home"]?["ipFieldHint"],
              color: context.colors.onPrimary,
              focusColor: context.colors.onPrimary,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              textInputType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.strings["form"]?["cantBeEmpty"];
                }

                if (!Validator.validateIPv4(value)) {
                  return context.strings["home"]?["invalidIp"];
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
              controller: _portFieldEC,
              maxLines: 1,
              label: context.strings["home"]?["portFieldLabel"],
              hint: context.strings["home"]?["portFieldHint"],
              color: context.colors.onPrimary,
              focusColor: context.colors.onPrimary,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              textInputType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.strings["form"]?["cantBeEmpty"];
                }

                if (!Validator.validatePort(value)) {
                  return context.strings["home"]?["invalidPort"];
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
