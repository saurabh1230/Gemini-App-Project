import 'package:isar/isar.dart';

part 'gemini_chat.g.dart';

@collection
class GeminiChat {
  Id? id;
  String? model, chat, sessionId, role, mimeType, imgBase64;
  String? photoUrl;
  DateTime? createdAt;
}
