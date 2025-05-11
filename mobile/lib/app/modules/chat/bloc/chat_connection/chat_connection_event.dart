part of 'chat_connection_bloc.dart';

sealed class ChatConnectionEvent {}

final class ChatConnectionConnect extends ChatConnectionEvent {}

final class ChatConnectionReceiveMessage extends ChatConnectionEvent {
  final MessageModel message;
  ChatConnectionReceiveMessage({required this.message});
}

final class ChatConnectionSendMessage extends ChatConnectionEvent {
  final String message;
  ChatConnectionSendMessage({required this.message});
}

//* Unused
// final class ChatConnectionSocketStatus extends ChatConnectionEvent {
//   final SocketStatus status;
//   ChatConnectionSocketStatus({required this.status});
// }
