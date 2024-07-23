class SpottersListModel {
  int? id;
  int? category;
  String? title;
  String? content;
  String? image;
  String? createdAt;
  String? updatedAt;

  SpottersListModel(
      {this.id,
        this.category,
        this.title,
        this.content,
        this.image,
        this.createdAt,
        this.updatedAt});

  SpottersListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['title'] = this.title;
    data['content'] = this.content;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
