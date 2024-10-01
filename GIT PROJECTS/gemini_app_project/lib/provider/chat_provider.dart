import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:mime/mime.dart';
import 'package:gemini_app_project/core/constants/strings.dart';
import 'package:gemini_app_project/core/utils/enums.dart';
import 'package:gemini_app_project/core/utils/utils.dart';
import 'package:gemini_app_project/db/chat/gemini_chat.dart';
import 'package:gemini_app_project/db/isar_constant.dart';
import 'package:gemini_app_project/model/chat_model.dart';
import 'package:gemini_app_project/services/chat_services.dart';

class ChatProvider extends ChangeNotifier {
  // ChatProvider() {
  //   init();
  // }

  ChatServices chatServices = ChatServices();

  File? _selectedFile;

  File? get selectedFile => _selectedFile;

  final ImagePicker _picker = ImagePicker();

  final List<Chat> _chatMessages = [];

  List<Chat> get chatMessages => _chatMessages;

  List<GeminiChat> _dbChat = [];
  List<GeminiChat> get dbChat => _dbChat;

  bool isLoading = false;
  bool isFavorite = false;

  String? _mime;
  String? _imgBase64;

  String sessionId = '';

  // File picker
  Future<void> selectFile({ImageSource source = ImageSource.gallery}) async {
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      _selectedFile = File(image.path);

      _mime = lookupMimeType(_selectedFile!.path); // Lookup mime type

      final bytes = _selectedFile!.readAsBytesSync(); // Read as bytes
      _imgBase64 = base64Encode(bytes); // base64 encode
      notifyListeners();
    } else {
      clearSelection();
    }
  }

  // Get response
  Future<void> chat(String text) async {
    try {
      isLoading = true;
      _chatMessages.add(
        Chat(
          imgData: _imgBase64 != null
              ? InlineData(
                  mimeType: _mime,
                  data: _imgBase64,
                )
              : null,
          chats: ChatMsgModel(
            role: Role.user.name,
            parts: [
              ChatPartModel(
                text: text,
              ),
            ],
          ),
          createdAt: DateTime.now(),
        ),
      );

      final String gModel = _imgBase64 != null
          ? GeminiEnum.geminiProVision.name!
          : GeminiEnum.geminiPro.name!;

      var chat1 = GeminiChat()
        ..chat = text
        ..model = gModel
        ..sessionId = sessionId
        ..mimeType = _mime
        ..imgBase64 = _imgBase64
        ..photoUrl = _selectedFile?.path
        ..role = Role.user.name
        ..createdAt = DateTime.now();

      _dbChat.add(chat1);
      notifyListeners();

      final chat = await chatServices.getGeminiChat(
        _chatMessages,
        gModel,
        _imgBase64,
        text,
        _mime,
      );

      final chatText = chat?.candidates?.first.content?.parts?.first.text ?? '';

      if (chatText.isNotEmpty) {
        _chatMessages.add(
          Chat(
            imgData: null,
            chats: ChatMsgModel(
              role: Role.model.name,
              parts: [ChatPartModel(text: chatText)],
            ),
            createdAt: DateTime.now(),
          ),
        );
        var chat2 = GeminiChat()
          ..chat = chatText
          ..sessionId = sessionId
          ..role = Role.model.name
          ..createdAt = DateTime.now();

        _dbChat.add(chat2);
      }
      isLoading = false;
      clearSelection();
      notifyListeners();
    } catch (e) {
      _chatMessages.add(
        Chat(
          imgData: null,
          chats: ChatMsgModel(
            role: Role.model.name,
            parts: [
              ChatPartModel(text: 'Ops! Chat interrupted! Please try again.'),
            ],
          ),
          createdAt: DateTime.now(),
        ),
      );
      isLoading = false;
      log('GEMINI ERROR: $e');
      notifyListeners();
    }
  }

  void clearSelection() {
    _selectedFile = null;
    _mime = null;
    _imgBase64 = null;
    notifyListeners();
  }

  void clearChats() {
    _chatMessages.clear();
    notifyListeners();
  }

  disposeChat() {
    isFavorite = false;
    _chatMessages.clear();
    _dbChat.clear();
    notifyListeners();
  }

  String getTimeNow(DateTime chatTime) {
    // final now = DateTime.now();
    String time = DateFormat('hh:mm a').format(chatTime);
    return time;
  }

  // Favorite click
  favoriteClick(context) async {
    if (_chatMessages.isEmpty) return;
    isFavorite = !isFavorite;
    if (isFavorite) {
      // add to favorite
      for (var chat in _dbChat) {
        addChat(chat);
      }
      snackbar(
        context,
        AppStrings.chatsAddedToFavorite,
        backgroundColor: Colors.green,
      );
    } else {
      // remove from favorite
      removeChat(_dbChat);
      snackbar(
        context,
        AppStrings.chatsRemoveFromFavorite,
        backgroundColor: Colors.red,
      );
    }

    getAllChats();
    notifyListeners();
  }

  //Get favorite chats
  Future<List<GeminiChat>> getFavoriteChats() async {
    final isarService = await isar;
    return isarService.geminiChats.where().findAll();
  }

  /// `Add/Update` image to database. Required fields `chat & model`
  Future<void> addChat(GeminiChat chat) async {
    var isarService = await isar;

    isarService.writeTxnSync(() async {
      int id = isarService.geminiChats.putSync(chat);

      log('Database Updated: $id');
    });
    _dbChat = await getFavoriteChats();
    notifyListeners();
  }

  /// `Delete` image from database. Required fields `index`
  Future removeChat(List<GeminiChat> chats) async {
    isFavorite = false;
    var isarService = await isar;
    for (var data in chats) {
      var otherImg =
          await isarService.geminiChats.where().idEqualTo(data.id!).findAll();

      await isarService.writeTxn(() async {
        bool deleted = await isarService.geminiChats.delete(otherImg.first.id!);

        if (deleted) {
          if (kDebugMode) {
            print('Database deleted otherImg: ${otherImg.first.id}');
          }
        } else {
          if (kDebugMode) {
            print('DB image delete unsuccessful: ${otherImg.first.id}');
          }
        }
      });
    }
    _dbChat = await getFavoriteChats();
    notifyListeners();
  }

  /// `Update` chats from database. Required fields `chats`
  Future<void> updateChatsGemini(List<GeminiChat> chats) async {
    _chatMessages.clear();
    sessionId = chats.first.sessionId!;
    isFavorite = true;
    for (var chat in chats) {
      _chatMessages.add(
        Chat(
          imgData: chat.imgBase64 != null
              ? InlineData(
                  mimeType: chat.mimeType,
                  data: chat.imgBase64,
                )
              : null,
          chats: ChatMsgModel(
            role: chat.role ?? '',
            parts: [
              ChatPartModel(
                text: chat.chat,
              ),
            ],
          ),
          createdAt: chat.createdAt,
        ),
      );
    }
    getAllChats();
    notifyListeners();
  }

  /// Get all chats from database if available else add to database
  Future<void> getAllChats() async {
    var dbChats = await getFavoriteChats();
    if (dbChats.isNotEmpty) {
      _dbChat = dbChats;
    } else {
      for (var chat in _chatMessages) {
        var chat1 = GeminiChat()
          ..chat = chat.chats!.parts.first.text
          ..model = GeminiEnum.geminiPro.name!
          ..sessionId = sessionId
          ..mimeType = chat.imgData?.mimeType
          ..imgBase64 = chat.imgData?.data
          ..photoUrl = chat.imgData?.data
          ..role = chat.chats!.role
          ..createdAt = chat.createdAt;

        _dbChat.add(chat1);
        addChat(chat1);
      }
    }
    notifyListeners();
  }
}
