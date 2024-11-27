import 'dart:async';
import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:websocket_flutter/app/data/models/message_model.dart';
import 'package:websocket_flutter/app/data/models/user_model.dart';
import 'package:websocket_flutter/app/data/websocket/websocket_events.dart';

class WebsocketClient {
  StreamController<MessageModel> messageStreamController = StreamController<MessageModel>();
  final String host;
  final String port;
  late String url;
  late IO.Socket client;

  WebsocketClient({
    required this.host,
    required this.port,
  }) {
    url = 'http://$host:$port';
  }

  Future<void> connect({required UserModel user}) async {
    client = IO.io(
      url,
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );

    setUpEvents(client, user);
  }

  Future<void> disconnect() async {
    client.disconnect();
    await messageStreamController.close();
  }

  Stream<MessageModel>? messageStream() {
    if (!messageStreamController.isClosed) {
      return messageStreamController.stream;
    }
    return null;
  }

  void setUpEvents(IO.Socket socket, UserModel user) {
    socket.on(
      WebsocketEvents.connect.event,
      (data) {
        _sendConnectionMessage(name: user.name);
      },
    );

    socket.on(
      WebsocketEvents.message.event,
      (data) {
        final MessageModel message = MessageModel.fromJson(data);
        messageStreamController.add(message);
      },
    );
  }

  void _sendConnectionMessage({required String name}) {
    if (client.connected) {
      client.emit(
        WebsocketEvents.connectionMessage.event,
        jsonEncode({
          'name': name,
        }),
      );
    }
  }
}
