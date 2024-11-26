part of 'chat_connection_bloc.dart';

enum ChatConnectionStatus {
  disconnected,
  connected,
  error,
  connecting,
}

final class ChatConnectionState extends Equatable {
  const ChatConnectionState({required this.status});

  final ChatConnectionStatus status;

  @override
  List<Object?> get props => [status];
}
