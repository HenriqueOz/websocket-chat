// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageModel {
  final String author;
  final String body;
  final DateTime date;

  MessageModel({
    required this.author,
    required this.body,
    required this.date,
  });

  factory MessageModel.fromJson(String json) {
    final Map<String, dynamic> data = jsonDecode(json);

    return MessageModel(
      author: data['author'] as String,
      body: data['body'] as String,
      date: DateTime.parse(data['date'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'auhtor': author,
      'body': body,
      'date': date,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
