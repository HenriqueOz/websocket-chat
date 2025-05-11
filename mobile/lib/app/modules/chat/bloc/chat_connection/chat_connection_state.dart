part of 'chat_connection_bloc.dart';

enum ChatConnectionStatus {
  disconnected,
  connected,
  error,
  connecting,
}

final class ChatConnectionState extends Equatable {
  final ChatConnectionStatus status;
  final List<MessageModel> messages;
  final SocketStatus socketStatus;

  const ChatConnectionState({required this.socketStatus, required this.status, required this.messages});

  ChatConnectionState updateMessages(MessageModel message) {
    final List<MessageModel> updatedMessages = List<MessageModel>.from(messages);
    updatedMessages.add(message);

    return copyWith(
      messages: updatedMessages,
    );
  }

  ChatConnectionState updateSocketStatus(SocketStatus status) {
    return copyWith(
      socketStatus: status,
    );
  }

  @override
  List<Object?> get props => [status, messages, socketStatus];

  ChatConnectionState copyWith({
    ChatConnectionStatus? status,
    List<MessageModel>? messages,
    SocketStatus? socketStatus,
  }) {
    return ChatConnectionState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      socketStatus: socketStatus ?? this.socketStatus,
    );
  }
}
