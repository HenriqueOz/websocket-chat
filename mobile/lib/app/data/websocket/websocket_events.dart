enum WebsocketEvents {
  connect(event: 'connect'),
  message(event: 'message'),
  disconnect(event: 'disconnect'),
  connectError(event: 'connect_error'),
  connectionMessage(event: 'connection-message');

  final String event;

  const WebsocketEvents({required this.event});
}
