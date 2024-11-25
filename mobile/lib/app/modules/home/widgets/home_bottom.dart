import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';
import 'package:websocket_flutter/app/core/strings/strings.dart';
import 'package:websocket_flutter/app/core/utils/messenger.dart';
import 'package:websocket_flutter/app/core/widgets/custom_text_form_field.dart';
import 'package:websocket_flutter/app/modules/home/bloc/home_form_bloc.dart';

class HomeBottom extends StatefulWidget {
  const HomeBottom({super.key});

  @override
  State<HomeBottom> createState() => _HomeBottomState();
}

class _HomeBottomState extends State<HomeBottom> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<HomeFormBloc>().add(HomeFormAddFormState(formState: _formState));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.safeAreaSize.width,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 50),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: context.colors.surface,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: context.colors.shadow.withOpacity(.5),
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            Strings.homeBottomTitle,
            style: context.theme.textTheme.titleMedium?.apply(
              color: context.colors.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
            key: _formState,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: CustomTextFormField(
              color: context.colors.onSurface,
              focusColor: context.colors.primary,
              hint: Strings.homeUsernameFieldHint,
              label: Strings.homeUsernameFieldLabel,
              textInputType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return Strings.formCantBeEmpty;
                }

                if (value.length < 5) {
                  return Strings.formMinimunChars(5);
                }

                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d\w]')),
                LengthLimitingTextInputFormatter(20),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              final HomeFormBloc bloc = context.read<HomeFormBloc>();

              bloc.add(HomeFormSubmit(
                onError: () => Messenger.of(context).showSnackbar(
                  message: Strings.formInvalidForm,
                  backgroundColor: context.colors.error,
                  textColor: context.colors.onError,
                ),
                onSuccess: () => Messenger.of(context).showSnackbar(
                  message: 'Fine',
                  backgroundColor: context.colors.primary,
                  textColor: context.colors.onPrimary,
                ),
              ));
            },
            child: const Text(Strings.homeJoinChatButton),
          ),
        ],
      ),
    );
  }
}
