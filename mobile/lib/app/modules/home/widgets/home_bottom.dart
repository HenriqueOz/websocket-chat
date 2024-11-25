import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';
import 'package:websocket_flutter/app/core/strings/strings.dart';
import 'package:websocket_flutter/app/core/widgets/custom_text_form_field.dart';

class HomeBottom extends StatelessWidget {
  const HomeBottom({super.key});

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
          CustomTextFormField(
            color: context.colors.onSurface,
            focusColor: context.colors.primary,
            hint: 'ex: GeorgeCuriso',
            label: 'Username',
            textInputType: TextInputType.name,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d\w]')),
              LengthLimitingTextInputFormatter(20),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Join Chat'),
          ),
        ],
      ),
    );
  }
}
