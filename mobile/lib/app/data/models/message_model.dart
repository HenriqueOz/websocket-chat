// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageModel {
  final String author;
  final String body;
  final String date;
  final String messageType;

  MessageModel({
    required this.author,
    required this.body,
    required this.date,
    required this.messageType,
  });

  factory MessageModel.fromJson(String json) {
    final Map<String, dynamic> data = jsonDecode(json);

    return MessageModel(
      author: data['author'] as String,
      body: data['body'] as String,
      date: data['date'] as String,
      messageType: data['messageType'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'auhtor': author,
      'body': body,
      'date': date,
      'messageType': messageType,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
