part of 'chat_connection_bloc.dart';

sealed class ChatConnectionEvent {}

final class ChatConnectionConnect extends ChatConnectionEvent {}

final class ChatConnectionDisconnect extends ChatConnectionEvent {}
