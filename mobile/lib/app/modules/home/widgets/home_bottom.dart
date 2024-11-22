import 'package:flutter/material.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';
import 'package:websocket_flutter/app/core/strings/strings.dart';
import 'package:websocket_flutter/app/core/widgets/custom_text_form_field.dart';

class HomeBottom extends StatelessWidget {
  const HomeBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.safeAreaSize.width,
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
      child: Center(
        child: Container(
          width: context.safeAreaSize.width * .7,
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              Text(
                Strings.homeBottomTitle,
                style: context.theme.textTheme.titleMedium,
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
        ),
      ),
    );
  }
}
