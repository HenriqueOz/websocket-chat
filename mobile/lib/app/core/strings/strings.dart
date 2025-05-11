import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';

final class Strings {
  static Strings? instance;
  Map<String, dynamic> data = {};

  Strings._();

  factory Strings.lazySingleton() {
    instance ??= Strings._();
    return instance!;
  }

  Future<void> loadFromFile({required String fileName}) async {
    try {
      data = jsonDecode(await rootBundle.loadString('assets/localization/$fileName.json'));
    } on Exception catch (e, s) {
      log('Error while loading language json', error: e, stackTrace: s);
    }
  }
}
