class InfoModel {
  String? firstname;
  String? lastname;
  String? username;
  String? email;
  String? mobile;

  InfoModel(
      {this.firstname, this.lastname, this.username, this.email, this.mobile});

  InfoModel.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    username = json['username'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['username'] = this.username;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    return data;
  }
}
