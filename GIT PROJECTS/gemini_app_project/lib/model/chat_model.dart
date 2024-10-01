// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Chat {
  final InlineData? imgData;
  final ChatMsgModel? chats;
  final DateTime? createdAt;

  Chat({this.imgData, this.chats, this.createdAt});
}

class ChatMsgModel {
  final String role;
  final List<ChatPartModel> parts;
  ChatMsgModel({
    required this.role,
    required this.parts,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'role': role,
      'parts': parts.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatMsgModel.fromMap(Map<String, dynamic> map) {
    return ChatMsgModel(
      role: map['role'] as String,
      parts: List<ChatPartModel>.from(
        (map['parts'] as List<int>).map<ChatPartModel>(
          (x) => ChatPartModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMsgModel.fromJson(String source) =>
      ChatMsgModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ChatPartModel {
  final InlineData? inlineData;
  final String? text;

  ChatPartModel({
    this.inlineData,
    this.text,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'inlineData': inlineData?.toMap(),
      'text': text,
    };
  }

  factory ChatPartModel.fromMap(Map<String, dynamic> map) {
    return ChatPartModel(
      inlineData: map['inlineData'] != null
          ? InlineData.fromMap(map['inlineData'] as Map<String, dynamic>)
          : null,
      text: map['text'] != null ? map['text'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatPartModel.fromJson(String source) =>
      ChatPartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class InlineData {
  final String? mimeType;
  final String? data;

  InlineData({
    this.mimeType,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mimeType': mimeType,
      'data': data,
    };
  }

  factory InlineData.fromMap(Map<String, dynamic> map) {
    return InlineData(
      mimeType: map['mimeType'] != null ? map['mimeType'] as String : null,
      data: map['data'] != null ? map['data'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InlineData.fromJson(String source) =>
      InlineData.fromMap(json.decode(source) as Map<String, dynamic>);
}
