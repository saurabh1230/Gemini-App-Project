import 'dart:convert';

// Main model class
class SearchModel {
  final int? id; // Make id nullable
  final int? category; // Make category nullable
  final String title;
  final String content;

  SearchModel({
    this.id, // Nullable id
    this.category, // Nullable category
    required this.title,
    required this.content,
  });

  // Factory method to create a SearchModel instance from JSON
  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['id'] != null ? json['id'] as int : null, // Handle null explicitly
      category: json['category'] != null ? json['category'] as int : null, // Handle null explicitly
      title: json['title'] ?? 'No Title', // Default value if null
      content: json['content'] ?? '', // Default value if null
    );
  }

  // Method to convert SearchModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'content': content,
    };
  }
}
