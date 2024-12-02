import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';
import 'package:websocket_flutter/app/core/theme/extensions/button_themes.dart';
import 'package:websocket_flutter/app/core/widgets/custom_text_form_field.dart';
import 'package:websocket_flutter/app/modules/chat/bloc/chat_connection/chat_connection_bloc.dart';

class ChatMessageInput extends StatefulWidget {
  const ChatMessageInput({super.key});

  @override
  State<ChatMessageInput> createState() => _ChatMessageInputState();
}

class _ChatMessageInputState extends State<ChatMessageInput> {
  final TextEditingController _inputEC = TextEditingController();

  @override
  void dispose() {
    _inputEC.dispose();
    super.dispose();
  }

  bool _validateInput(String input) {
    final RegExp regex = RegExp(r'\s');
    final int spaceCount = regex.allMatches(input).length;

    return input.isNotEmpty && input.length != spaceCount;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow.withOpacity(.2),
            blurRadius: 3,
          )
        ],
        color: context.colors.surface,
      ),
      child: Row(
        children: [
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 30,
                maxHeight: 120,
              ),
              child: CustomTextFormField(
                controller: _inputEC,
                color: context.colors.onSurface,
                focusColor: context.colors.primary,
                isDense: true,
                enableSuggestions: true,
                autocorrect: true,
                textInputType: TextInputType.multiline,
                fillColor: context.colors.surfaceBright,
                hint: context.strings["chat"]?["messageInputHint"],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              if (_validateInput(_inputEC.text)) {
                context.read<ChatConnectionBloc>().add(
                      ChatConnectionSendMessage(
                        message: _inputEC.text,
                      ),
                    );
                _inputEC.clear();
              }
            },
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
    );
  }
}
