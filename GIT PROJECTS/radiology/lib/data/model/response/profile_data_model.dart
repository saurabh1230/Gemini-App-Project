class ProfileModel {
  int? id;
  String? firstname;
  String? lastname;
  String? email;
  String? mobile;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;
  // Null? googleId;
  // String? avatar;
  // Null? deletedAt;
  // String? username;

  ProfileModel(
      {this.id,
        this.firstname,
        this.lastname,
        this.email,
        this.mobile,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
        // this.fcmToken,
        // this.googleId,
        // this.avatar,
        // this.deletedAt,
        // this.username
      });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    mobile = json['mobile'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // fcmToken = json['fcm_token'];
    // googleId = json['google_id'];
    // avatar = json['avatar'];
    // deletedAt = json['deleted_at'];
    // username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    // data['fcm_token'] = this.fcmToken;
    // data['google_id'] = this.googleId;
    // data['avatar'] = this.avatar;
    // data['deleted_at'] = this.deletedAt;
    // data['username'] = this.username;
    return data;
  }
}
