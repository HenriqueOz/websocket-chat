import 'package:flutter/material.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';
import 'package:websocket_flutter/app/core/theme/extensions/button_themes.dart';
import 'package:websocket_flutter/app/core/widgets/custom_text_form_field.dart';

class ChatMessageInput extends StatelessWidget {
  const ChatMessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: context.colors.surfaceDim.withOpacity(.75),
        ),
        child: Row(
          children: [
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 30,
                  maxHeight: 120,
                ),
                child: SingleChildScrollView(
                  reverse: true,
                  child: CustomTextFormField(
                    color: context.colors.onSurface,
                    focusColor: context.colors.primary,
                    isDense: true,
                    fillColor: context.colors.surfaceBright,
                    hint: 'Type your message',
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {},
              style: context.theme.extension<ButtonThemes>()?.primaryButton.copyWith(
                    shape: const WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
              padding: const EdgeInsets.all(12),
              icon: const Icon(Icons.send),
            )
          ],
        ),
      ),
    );
  }
}
