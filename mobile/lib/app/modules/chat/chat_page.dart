import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';
import 'package:websocket_flutter/app/core/routes/routes.dart';
import 'package:websocket_flutter/app/core/theme/extensions/button_themes.dart';
import 'package:websocket_flutter/app/core/utils/messenger.dart';
import 'package:websocket_flutter/app/core/widgets/app_drawer.dart';
import 'package:websocket_flutter/app/core/widgets/custom_app_bar.dart';
import 'package:websocket_flutter/app/data/models/message_model.dart';
import 'package:websocket_flutter/app/data/models/user_model.dart';
import 'package:websocket_flutter/app/data/websocket/websocket_client.dart';
import 'package:websocket_flutter/app/modules/chat/bloc/chat_connection/chat_connection_bloc.dart';

class ChatPage extends StatefulWidget {
  final UserModel user;

  const ChatPage({
    super.key,
    required this.user,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatConnectionBloc controller;

  @override
  void initState() {
    controller = context.read<ChatConnectionBloc>()..add(ChatConnectionConnect());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        Messenger.of(context).showCustomDialog(
          title: 'Exit chat?',
          description: 'You will be disconnected from the chat room',
          actions: [
            ElevatedButton(
              style: context.theme.extension<ButtonThemes>()?.errorButton,
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName(RouteNames.homePage));
              },
              child: const Text('Exit'),
            ),
            ElevatedButton(
              style: context.theme.extension<ButtonThemes>()?.primaryButton,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
      child: Scaffold(
        appBar: CustomAppBar(
          backgroundColor: context.colors.primary,
          foregroundColor: context.colors.onPrimary,
          title: BlocSelector<ChatConnectionBloc, ChatConnectionState, SocketStatus>(
            selector: (state) {
              return state.socketStatus;
            },
            builder: (context, status) {
              return Text(
                'status: ${status.status}',
                style: TextStyle(
                  color: context.colors.onPrimary,
                ),
              );
            },
          ),
        ),
        drawer: const AppDrawer(),
        body: Center(
          child: Column(
            children: [
              BlocSelector<ChatConnectionBloc, ChatConnectionState, List<MessageModel>>(
                selector: (state) {
                  return state.messages;
                },
                builder: (context, messages) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final MessageModel message = messages[index];

                      return Text(
                        message.body,
                        style: TextStyle(
                          color: context.colors.onSurface,
                        ),
                        textAlign: TextAlign.center,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
