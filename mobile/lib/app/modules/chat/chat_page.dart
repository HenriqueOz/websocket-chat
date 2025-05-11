import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';
import 'package:websocket_flutter/app/core/routes/routes.dart';
import 'package:websocket_flutter/app/core/theme/extensions/button_themes.dart';
import 'package:websocket_flutter/app/core/utils/messenger.dart';
import 'package:websocket_flutter/app/core/widgets/app_drawer.dart';
import 'package:websocket_flutter/app/data/models/user_model.dart';
import 'package:websocket_flutter/app/modules/chat/bloc/chat_connection/chat_connection_bloc.dart';
import 'package:websocket_flutter/app/modules/chat/widgets/chat_app_bar.dart';
import 'package:websocket_flutter/app/modules/chat/widgets/chat_message_input.dart';
import 'package:websocket_flutter/app/modules/chat/widgets/chat_message_list.dart';

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

  void _onPopInvokedWithResult(bool didPop, Object? result) {
    if (didPop) return;

    Messenger.of(context).showCustomDialog(
      title: context.strings["chat"]?["exitModalTitle"] ?? '',
      description: context.strings["chat"]?["exitModalDescription"] ?? '',
      actions: [
        ElevatedButton(
          style: context.theme.extension<ButtonThemes>()?.errorButton,
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName(RouteNames.homePage));
          },
          child: Text(context.strings["label"]?["exit"] ?? ''),
        ),
        ElevatedButton(
          style: context.theme.extension<ButtonThemes>()?.primaryButton,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(context.strings["label"]?["cancel"] ?? ''),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _onPopInvokedWithResult,
      child: Scaffold(
        backgroundColor: context.colors.surfaceDim,
        appBar: const ChatAppBar(),
        drawer: const AppDrawer(),
        body: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: context.safeAreaSizeWithoutAppBar.height,
          ),
          child: Column(
            children: [
              const Expanded(
                child: ChatMessageList(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: context.safeAreaSize.width,
                  child: const ChatMessageInput(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
