import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';
import 'package:websocket_flutter/app/data/models/message_model.dart';
import 'package:websocket_flutter/app/modules/chat/bloc/chat_connection/chat_connection_bloc.dart';
import 'package:websocket_flutter/app/modules/chat/bloc/message_type.dart';
import 'package:websocket_flutter/app/modules/chat/widgets/chat_message.dart';

enum ScrollMode {
  bottomAttach,
  free,
}

class ChatMessageList extends StatefulWidget {
  const ChatMessageList({super.key});

  @override
  State<ChatMessageList> createState() => _ChatMessageListState();
}

class _ChatMessageListState extends State<ChatMessageList> {
  final ScrollController _scrollController = ScrollController();
  ScrollMode _scrollMode = ScrollMode.bottomAttach;

  void _scrollDown() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  void _scrollModeListener() {
    if (_scrollController.hasClients) {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent - 10) {
        _scrollMode = ScrollMode.bottomAttach;
      } else {
        _scrollMode = ScrollMode.free;
      }
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollModeListener);
    _scrollDown();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollModeListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChatConnectionBloc, ChatConnectionState, List<MessageModel>>(
      selector: (state) {
        return state.messages;
      },
      builder: (_, messages) {
        final int lengthWithFirstItem = messages.length + 1;

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          controller: _scrollController,
          itemCount: lengthWithFirstItem,
          itemBuilder: (_, index) {
            if (_scrollMode == ScrollMode.bottomAttach) {
              Future<void>.microtask(() => _scrollDown());
            }

            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Messages',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: context.colors.onSurface,
                  ),
                ),
              );
            }

            final int indexAdjust = index - 1;
            final MessageModel message = messages[indexAdjust];
            final MessageType messageType = MessageType.fromString(message.messageType);

            switch (messageType) {
              case MessageType.system:
              case MessageType.user:
              case MessageType.member:
                return ChatMemberMessage(message: message);
              case MessageType.undefined:
            }
            return null;
          },
        );
      },
    );
  }
}
