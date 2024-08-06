class NoteListModel {
  int? id;
  String? name;
  int? parentId;
  String? color;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? notesCount;
  int? readnotes;

  NoteListModel(
      {this.id,
        this.name,
        this.parentId,
        this.color,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.notesCount,
        this.readnotes});

  NoteListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    color = json['color'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    notesCount = json['notes_count'];
    readnotes = json['read_note'];
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
    data['notes_count'] = this.notesCount;
    data['read_note'] = this.readnotes;
    return data;
  }
}
