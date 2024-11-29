enum MessageType {
  system,
  user,
  member,
  undefined;

  static MessageType fromString(String source) {
    final String lowerSource = source.toLowerCase();

    if (lowerSource == 'system') {
      return MessageType.system;
    } else if (lowerSource == 'member') {
      return MessageType.member;
    } else if (lowerSource == 'user') {
      return MessageType.user;
    } else {
      return MessageType.undefined;
    }
  }
}
