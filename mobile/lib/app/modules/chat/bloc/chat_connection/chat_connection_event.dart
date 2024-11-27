part of 'chat_connection_bloc.dart';

sealed class ChatConnectionEvent {}

final class ChatConnectionConnect extends ChatConnectionEvent {}

final class ChatConnectionRecieveMessage extends ChatConnectionEvent {
  final MessageModel message;
  ChatConnectionRecieveMessage({required this.message});
}

final class ChatConnectionSocketStatus extends ChatConnectionEvent {
  final SocketStatus status;
  ChatConnectionSocketStatus({required this.status});
}
