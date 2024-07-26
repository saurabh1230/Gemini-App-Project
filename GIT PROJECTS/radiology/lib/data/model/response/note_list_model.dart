class NoteListModel {
  int? id;
  String? name;
  String? color;
  int? status;
  String? createdAt;
  String? updatedAt;

  NoteListModel(
      {this.id,
        this.name,
        this.color,
        this.status,
        this.createdAt,
        this.updatedAt});

  NoteListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
