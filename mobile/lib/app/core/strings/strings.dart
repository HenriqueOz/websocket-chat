//TODO migrate strings to json file
final class Strings {
  static const String homeTitle = 'WebsocketClient\nchat';
  static const String homeSubtitle = 'A simple websocket chat app';
  static const String homeServerFormDescription = 'Edit the chat server address';
  static const String homeDrawerTitle = 'Menu';
  static const String homeDrawerDarkMode = 'Dark Mode';
  static const String homeBottomTitle = 'Pick a username to display in the chat';
  static const String homeInvalidIp = 'Invalid IP address';
  static const String homeInvalidPort = 'Invalid port';
  static const String homeJoinChatButton = 'Join chat';
  static const String homeIpFieldLabel = 'IP';
  static const String homeIpFieldHint = 'ex: 192.168.0.1';
  static const String homePortFieldLabel = 'Port';
  static const String homePortFieldHint = 'ex: 8080';
  static const String homeUsernameFieldLabel = 'Username';
  static const String homeUsernameFieldHint = 'ex: GeorgeCurioso';

  static const String chatExitModalTitle = 'Exit Chat?';
  static const String chatExitModalDescription = 'You will be disconnected from the chat room';
  static const String chatConnectionStatus = 'Connection Status';

  static String formMinimunChars(int minimun) => 'Field must have at least $minimun characters';
  static const String formCantBeEmpty = 'Field can\'t be empty';
  static const String formInvalidForm = 'Invalid form';

  static const String labelExit = 'Exit';
  static const String labelCancel = 'Cancel';
}
