import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';
import 'package:websocket_flutter/app/data/models/message_model.dart';
import 'package:websocket_flutter/app/modules/chat/bloc/message_type.dart';

class ChatMemberMessage extends StatelessWidget {
  final MessageModel message;

  const ChatMemberMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final bool isUser = MessageType.fromString(message.messageType) == MessageType.user;
    final DateFormat dateFormat = DateFormat('HH:mm');
    final double maxMessageWidth = context.safeAreaSize.width * .65;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxMessageWidth,
          ),
          child: IntrinsicWidth(
            child: Container(
              padding: const EdgeInsets.only(
                top: 2,
                left: 12,
                right: 12,
                bottom: 10,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: context.colors.shadow.withOpacity(.1),
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: context.colors.surfaceBright,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.author,
                    style: context.theme.textTheme.labelLarge?.copyWith(
                      color: isUser ? context.colors.secondary : context.colors.tertiary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    message.body,
                    style: TextStyle(
                      color: context.colors.onSurface,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        dateFormat.format(
                          DateTime.parse(message.date),
                        ),
                        style: context.theme.textTheme.labelSmall?.copyWith(
                          color: context.colors.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
