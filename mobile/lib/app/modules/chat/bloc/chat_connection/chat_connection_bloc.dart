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

  late StreamSubscription<MessageModel> _messageStreamSubscription;

  ChatConnectionBloc({
    required WebsocketClient websocket,
    required UserModel userModel,
  })  : _websocket = websocket,
        _userModel = userModel,
        super(
          const ChatConnectionState(
            status: ChatConnectionStatus.connecting,
            messages: [],
            socketStatus: SocketStatus.disconnected,
          ),
        ) {
    on<ChatConnectionConnect>(_chatConnect);
    on<ChatConnectionReceiveMessage>(_receiveMessage);

    _messageStreamSubscription = _websocket.messageStream.listen((message) {
      add(ChatConnectionReceiveMessage(message: message));
    });
  }

  Future<void> _chatConnect(ChatConnectionConnect event, Emitter<ChatConnectionState> emit) async {
    await _websocket.connect(user: _userModel);
  }

  Stream<SocketStatus> get statusStream => _websocket.statusStream;

  Future<void> _receiveMessage(ChatConnectionReceiveMessage event, Emitter<ChatConnectionState> emit) async {
    emit(state.updateMessages(event.message));
  }

  @override
  Future<void> close() {
    _websocket.disconnect();
    _websocket.dispose();
    _messageStreamSubscription.cancel();
    return super.close();
  }
}
