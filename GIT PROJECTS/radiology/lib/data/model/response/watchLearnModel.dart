class WatchLearnModel {
  final int id;
  final int category;
  final String title;
  final String videoUrl;
  final int? userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  WatchLearnModel({
    required this.id,
    required this.category,
    required this.title,
    required this.videoUrl,
    this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to parse from JSON
  factory WatchLearnModel.fromJson(Map<String, dynamic> json) {
    return WatchLearnModel(
      id: json['id'],
      category: json['category'],
      title: json['title'],
      videoUrl: json['video_url'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method to convert model back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'video_url': videoUrl,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
