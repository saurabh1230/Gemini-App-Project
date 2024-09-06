class TodaySpecialModel {
  final String description;
  final String image;
  final String title;

  TodaySpecialModel({
    required this.description,
    required this.image,
    required this.title,
  });

  // Factory constructor for creating a new instance from a map
  factory TodaySpecialModel.fromJson(Map<String, dynamic> json) {
    return TodaySpecialModel(
      description: json['description'],
      image: json['image'],
      title: json['title'],
    );
  }

  // Method for converting an instance to a map
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'image': image,
      'title': title,
    };
  }
}
