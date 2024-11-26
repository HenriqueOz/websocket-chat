import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';
import 'package:websocket_flutter/app/core/widgets/app_drawer.dart';
import 'package:websocket_flutter/app/core/widgets/custom_app_bar.dart';
import 'package:websocket_flutter/app/data/models/user_model.dart';
import 'package:websocket_flutter/app/modules/chat/bloc/chat_connection_bloc.dart';

class ChatPage extends StatelessWidget {
  final UserModel user;

  const ChatPage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: context.colors.primary,
        foregroundColor: context.colors.onPrimary,
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: context.read<ChatConnectionBloc>().messageStream(),
              builder: (context, snapshot) {
                return Text(
                  snapshot.data?.body ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                context.read<ChatConnectionBloc>().add(ChatConnectionConnect());
              },
              child: const Text('Connect'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<ChatConnectionBloc>().add(ChatConnectionDisconnect());
              },
              child: const Text('Disconnect'),
            ),
          ],
        ),
      ),
    );
  }
}
