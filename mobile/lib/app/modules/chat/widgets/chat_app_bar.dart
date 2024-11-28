import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';
import 'package:websocket_flutter/app/core/strings/strings.dart';
import 'package:websocket_flutter/app/core/widgets/custom_app_bar.dart';
import 'package:websocket_flutter/app/data/websocket/websocket_client.dart';
import 'package:websocket_flutter/app/modules/chat/bloc/chat_connection/chat_connection_bloc.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      backgroundColor: context.colors.primary,
      foregroundColor: context.colors.onPrimary,
      elevation: 2,
      title: StreamBuilder(
        stream: context.read<ChatConnectionBloc>().statusStream,
        builder: (context, snapshot) {
          final SocketStatus? socketStatus = snapshot.data;

          return Column(
            children: [
              Text(
                Strings.chatConnectionStatus,
                style: TextStyle(
                  color: context.colors.onPrimary,
                ),
              ),
              Text(
                '${socketStatus?.status}',
                style: context.theme.textTheme.labelMedium?.copyWith(
                  color: context.colors.onPrimary,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
