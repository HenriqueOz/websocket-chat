import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';
import 'package:websocket_flutter/app/data/models/message_model.dart';

class ChatSystemMessage extends StatelessWidget {
  final MessageModel message;

  const ChatSystemMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('HH:mm');

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Align(
        alignment: Alignment.center,
        child: IntrinsicWidth(
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    message.author,
                    style: context.theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colors.secondary,
                    ),
                  ),
                  Text(
                    message.body,
                    style: context.theme.textTheme.labelSmall?.copyWith(
                      color: context.colors.onSurface,
                    ),
                  ),
                ],
              ),
              Text(
                dateFormat.format(
                  DateTime.parse(message.date),
                ),
                style: context.theme.textTheme.labelSmall?.copyWith(
                  color: context.colors.onSurface.withOpacity(.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
