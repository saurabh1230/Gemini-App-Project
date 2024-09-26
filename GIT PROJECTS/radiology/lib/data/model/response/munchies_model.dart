class MunchiesModel {
  int? id;
  int? category;
  String? title;
  String? content;
  String? userId;
  String? createdAt;
  String? updatedAt;
  Categories? categories;

  MunchiesModel(
      {this.id,
        this.category,
        this.title,
        this.content,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.categories});

  MunchiesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    title = json['title'];
    content = json['content'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categories = json['categories'] != null
        ? new Categories.fromJson(json['categories'])
        : null;
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
    if (this.categories != null) {
      data['categories'] = this.categories!.toJson();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  int? parentId;
  String? color;
  int? status;
  String? createdAt;
  String? updatedAt;

  Categories(
      {this.id,
        this.name,
        this.parentId,
        this.color,
        this.status,
        this.createdAt,
        this.updatedAt});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    color = json['color'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['color'] = this.color;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
