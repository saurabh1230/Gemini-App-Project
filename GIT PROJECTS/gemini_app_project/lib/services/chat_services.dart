import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gemini_app_project/core/config/config.dart';
import 'package:gemini_app_project/core/constants/constants.dart';
import 'package:gemini_app_project/model/chat_model.dart';
import 'package:gemini_app_project/model/gemini_response_model.dart';

class ChatServices {
  Future<GeminiResponseModel?> getGeminiChat(
    List<Chat> preMessages,
    String model,
    String? image,
    String text,
    String? mime,
  ) async {
    try {
      Dio dio = Dio();

      List<Map<String, dynamic>> contents =
          preMessages.map((e) => e.chats!.toMap()).toList();

      Map<String, dynamic> generationConfig = {
        "temperature": image != null ? 0.4 : 0.9,
        "topK": image != null ? 32 : 1,
        "topP": 1,
        "maxOutputTokens": image != null ? 4096 : 2048,
        "stopSequences": [],
      };

      var imgContent = [
        {
          "parts": [
            {"text": text},
            {
              "inlineData": {
                "mimeType": mime,
                "data": image,
              },
            },
          ],
        }
      ];

      final Response response = await dio.post(
        // AppConfig.BASE_URL,
        '${AppConfig.BASE_URL}$model:generateContent?key=$API_KEY', //streamGenerateContent
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),

        data: {
          "contents": image != null ? imgContent : contents,
          "generationConfig": generationConfig,
          "safetySettings": [
            {
              "category": "HARM_CATEGORY_HARASSMENT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE",
            },
            {
              "category": "HARM_CATEGORY_HATE_SPEECH",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE",
            },
            {
              "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE",
            },
            {
              "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE",
            }
          ],
        },
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        log(response.toString());
        return GeminiResponseModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      log('Error: $e');
    }
    return null;
  }
}
