import 'dart:async';
import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:websocket_flutter/app/data/models/message_model.dart';
import 'package:websocket_flutter/app/data/models/user_model.dart';
import 'package:websocket_flutter/app/data/websocket/websocket_events.dart';

enum SocketStatus {
  connected('connected'),
  disconnected('disconnected'),
  reconnecting('reconnecting');

  final String status;
  const SocketStatus(this.status);
}

class WebsocketClient {
  final String host;
  final String port;
  late String url;
  IO.Socket? client;
  final StreamController<MessageModel> messageStreamController = StreamController<MessageModel>();
  final StreamController<SocketStatus> statusStreamController = StreamController<SocketStatus>();

  WebsocketClient({
    required this.host,
    required this.port,
  }) {
    url = 'http://$host:$port';
  }

  Stream<MessageModel> get messageStream => messageStreamController.stream;
  Stream<SocketStatus> get statusStream => statusStreamController.stream;

  /* Nota de ódio
  * Por algum motivo o socket io não instancia um novo server quanto
  * tu chama o método que de criação de server. Ele busca a instância criada no passado
  * e muda o endereço dela e etc. Mas, ESSE INFELIZ, não apaga os eventos registrados
  * no último socket que tu criou, então, se você criar um novo dele e não limpar os listeners
  * ele duplica eventos
  *
  * Morra socket io
  */

  Future<void> connect({
    required final UserModel user,
  }) async {
    client = IO.io(
      url,
      IO.OptionBuilder().setTransports(['websocket']).disableAutoConnect().build(),
    );

    setUpEvents(client!, user);
    client?.connect();
  }

  void setUpEvents(IO.Socket socket, UserModel user) {
    socket.on(
      WebsocketEvents.connect.event,
      (data) {
        addDataToStream(statusStreamController, SocketStatus.connected);
        _sendConnectionMessage(name: user.name);
      },
    );

    socket.on(
      WebsocketEvents.message.event,
      (data) {
        addDataToStream(messageStreamController, MessageModel.fromJson(data));
      },
    );

    socket.onReconnectAttempt(
      (data) {
        addDataToStream<SocketStatus>(statusStreamController, SocketStatus.reconnecting);
      },
    );

    socket.onDisconnect(
      (data) {
        addDataToStream<SocketStatus>(statusStreamController, SocketStatus.disconnected);
      },
    );
  }

  void disconnect() {
    client?.disconnect();
    client?.clearListeners();
  }

  void dispose() async {
    await messageStreamController.close();
    await statusStreamController.close();
  }

  void sendMessage({required MessageModel message}) {
    client?.emit(WebsocketEvents.message.event, message.toJson());
  }

  void addDataToStream<T>(StreamController<T>? streamController, T data) {
    if (streamController != null && !streamController.isClosed) {
      streamController.sink.add(data);
    }
  }

  void _sendConnectionMessage({required String name}) {
    if (client != null && client!.connected) {
      client?.emit(
        WebsocketEvents.connectionMessage.event,
        jsonEncode({
          'name': name,
        }),
      );
    }
  }
}
