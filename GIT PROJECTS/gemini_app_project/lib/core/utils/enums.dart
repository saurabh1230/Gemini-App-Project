// Chat role
enum Role {
  user,
  model,
}

enum GeminiEnum {
  geminiPro,
  geminiProVision,
}

extension FilterTypeEnumExtension on GeminiEnum {
  static const actionNames = {
    GeminiEnum.geminiPro: "gemini-pro",
    GeminiEnum.geminiProVision: "gemini-pro-vision",
  };

  String? get name => actionNames[this];
}
