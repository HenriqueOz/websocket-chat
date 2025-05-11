class ServerAddressModel {
  final String port;
  final String ipv4;

  ServerAddressModel({
    required this.port,
    required this.ipv4,
  });

  @override
  String toString() {
    return 'ServerAddressModel(ipv4: $ipv4, port: $port)';
  }
}
