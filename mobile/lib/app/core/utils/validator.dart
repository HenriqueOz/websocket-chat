class Validator {
  static bool validateIPv4(String ip) {
    List<String> splitIp = ip.split('.');

    const int ipParts = 4;
    if (splitIp.length != ipParts) {
      return false;
    }

    const int ipMaxChars = 3;
    for (String part in splitIp) {
      if (part.isEmpty || part.length > ipMaxChars) {
        return false;
      }

      final int? parse = int.tryParse(part);
      const int ipMax = 255;
      const int ipMin = 0;
      if (parse == null || parse < ipMin || parse > ipMax) {
        return false;
      }
    }

    return true;
  }

  static bool validatePort(String port) {
    const int portMaxChars = 5;
    if (port.length > portMaxChars || port.isEmpty) {
      return false;
    }

    final int? parse = int.tryParse(port);
    if (parse == null) {
      return false;
    }

    const int portMin = 0;
    const int portMax = 65535;
    if (parse < portMin || parse > portMax) {
      return false;
    }

    return true;
  }
}
