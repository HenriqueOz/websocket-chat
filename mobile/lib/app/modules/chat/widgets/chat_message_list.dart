import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';
import 'package:websocket_flutter/app/data/models/message_model.dart';
import 'package:websocket_flutter/app/modules/chat/bloc/chat_connection/chat_connection_bloc.dart';

class ChatMessageList extends StatelessWidget {
  const ChatMessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChatConnectionBloc, ChatConnectionState, List<MessageModel>>(
      selector: (state) {
        return state.messages;
      },
      builder: (context, messages) {
        return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final MessageModel message = messages[index];

            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: context.safeAreaSize.width * .5,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: context.colors.surface,
                    ),
                    child: Column(
                      children: [
                        Text(message.author),
                        Text(message.body),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
