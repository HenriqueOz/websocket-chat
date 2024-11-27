import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:websocket_flutter/app/data/models/message_model.dart';
import 'package:websocket_flutter/app/data/models/user_model.dart';
import 'package:websocket_flutter/app/data/websocket/websocket_client.dart';

part 'chat_connection_event.dart';
part 'chat_connection_state.dart';

class ChatConnectionBloc extends Bloc<ChatConnectionEvent, ChatConnectionState> {
  final WebsocketClient _websocket;
  final UserModel _userModel;

  ChatConnectionBloc({
    required WebsocketClient websocket,
    required UserModel userModel,
  })  : _websocket = websocket,
        _userModel = userModel,
        super(
          const ChatConnectionState(
            status: ChatConnectionStatus.connecting,
          ),
        ) {
    on<ChatConnectionConnect>(_chatConnect);
    on<ChatConnectionDisconnect>(_chatDisconnect);
  }

  Future<void> _chatConnect(ChatConnectionConnect event, Emitter<ChatConnectionState> emit) async {
    await _websocket.connect(user: _userModel);
  }

  Future<void> _chatDisconnect(ChatConnectionDisconnect event, Emitter<ChatConnectionState> emit) async {
    await _websocket.disconnect();
  }

  Stream<MessageModel>? messageStream() {
    return _websocket.messageStream();
  }
}
