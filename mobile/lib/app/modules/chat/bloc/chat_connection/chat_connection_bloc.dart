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

  late StreamSubscription<MessageModel> messageSubscriptions;
  late StreamSubscription<SocketStatus> statusSubscriptions;

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
    on<ChatConnectionRecieveMessage>(_recieveMessage);
    on<ChatConnectionSocketStatus>(_socketStatus);

    messageSubscriptions = _websocket.messageStream.listen(
      (message) {
        add(ChatConnectionRecieveMessage(message: message));
      },
    );

    statusSubscriptions = _websocket.statusStream.listen(
      (status) {
        add(ChatConnectionSocketStatus(status: status));
      },
    );
  }

  Future<void> _chatConnect(ChatConnectionConnect event, Emitter<ChatConnectionState> emit) async {
    await _websocket.connect(user: _userModel);
    emit(state.copyWith(status: ChatConnectionStatus.connected));
  }

  Future<void> _recieveMessage(ChatConnectionRecieveMessage event, Emitter<ChatConnectionState> emit) async {
    emit(state.updateMessages(event.message));
  }

  Future<void> _socketStatus(ChatConnectionSocketStatus event, Emitter<ChatConnectionState> emit) async {
    emit(state.updateSocketStatus(event.status));
  }

  @override
  Future<void> close() {
    messageSubscriptions.cancel();
    statusSubscriptions.cancel();
    _websocket.disconnect();
    return super.close();
  }
}
