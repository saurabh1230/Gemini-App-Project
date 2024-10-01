import 'dart:convert';

GeminiResponseModel geminiResponseModelFromJson(String str) =>
    GeminiResponseModel.fromJson(json.decode(str));

class GeminiResponseModel {
  final List<Candidate>? candidates;
  final PromptFeedback? promptFeedback;

  GeminiResponseModel({
    this.candidates,
    this.promptFeedback,
  });

  factory GeminiResponseModel.fromJson(Map<String, dynamic> json) =>
      GeminiResponseModel(
        candidates: json["candidates"] == null
            ? []
            : List<Candidate>.from(
                json["candidates"]!.map((x) => Candidate.fromJson(x)),
              ),
        promptFeedback: json["promptFeedback"] == null
            ? null
            : PromptFeedback.fromJson(json["promptFeedback"]),
      );

  Map<String, dynamic> toJson() => {
        "candidates": candidates == null
            ? []
            : List<dynamic>.from(candidates!.map((x) => x.toJson())),
        "promptFeedback": promptFeedback?.toJson(),
      };
}

class Candidate {
  final Content? content;
  final String? finishReason;
  final int? index;
  final List<SafetyRating>? safetyRatings;

  Candidate({
    this.content,
    this.finishReason,
    this.index,
    this.safetyRatings,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        content:
            json["content"] == null ? null : Content.fromJson(json["content"]),
        finishReason: json["finishReason"],
        index: json["index"],
        safetyRatings: json["safetyRatings"] == null
            ? []
            : List<SafetyRating>.from(
                json["safetyRatings"]!.map((x) => SafetyRating.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "content": content?.toJson(),
        "finishReason": finishReason,
        "index": index,
        "safetyRatings": safetyRatings == null
            ? []
            : List<dynamic>.from(safetyRatings!.map((x) => x.toJson())),
      };
}

class Content {
  final List<Part>? parts;
  final String? role;

  Content({
    this.parts,
    this.role,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        parts: json["parts"] == null
            ? []
            : List<Part>.from(json["parts"]!.map((x) => Part.fromJson(x))),
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "parts": parts == null
            ? []
            : List<dynamic>.from(parts!.map((x) => x.toJson())),
        "role": role,
      };
}

class Part {
  final String? text;

  Part({
    this.text,
  });

  factory Part.fromJson(Map<String, dynamic> json) => Part(
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      };
}

class SafetyRating {
  final String? category;
  final String? probability;

  SafetyRating({
    this.category,
    this.probability,
  });

  factory SafetyRating.fromJson(Map<String, dynamic> json) => SafetyRating(
        category: json["category"],
        probability: json["probability"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "probability": probability,
      };
}

class PromptFeedback {
  final List<SafetyRating>? safetyRatings;

  PromptFeedback({
    this.safetyRatings,
  });

  factory PromptFeedback.fromJson(Map<String, dynamic> json) => PromptFeedback(
        safetyRatings: json["safetyRatings"] == null
            ? []
            : List<SafetyRating>.from(
                json["safetyRatings"]!.map((x) => SafetyRating.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "safetyRatings": safetyRatings == null
            ? []
            : List<dynamic>.from(safetyRatings!.map((x) => x.toJson())),
      };
}
