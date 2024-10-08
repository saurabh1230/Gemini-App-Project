class MunchiesDetailsModel {
  int? id;
  int? category;
  String? title;
  String? content;
  String? userId;
  String? createdAt;
  String? updatedAt;

  MunchiesDetailsModel(
      {this.id,
        this.category,
        this.title,
        this.content,
        this.userId,
        this.createdAt,
        this.updatedAt});

  MunchiesDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    title = json['title'];
    content = json['content'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['title'] = this.title;
    data['content'] = this.content;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
