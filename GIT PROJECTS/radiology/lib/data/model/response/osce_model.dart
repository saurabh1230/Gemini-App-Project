class OsceModel {
  int? id;
  String? title;
  String? image;
  String? createdAt;
  String? updatedAt;
  List<Question>? question;

  OsceModel(
      {this.id,
        this.title,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.question});

  OsceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['question'] != null) {
      question = <Question>[];
      json['question'].forEach((v) {
        question!.add(new Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.question != null) {
      data['question'] = this.question!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Question {
  int? id;
  int? osceId;
  String? question;
  String? answer;

  Question({this.id, this.osceId, this.question, this.answer});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    osceId = json['osce_id'];
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['osce_id'] = this.osceId;
    data['question'] = this.question;
    data['answer'] = this.answer;
    return data;
  }
}
