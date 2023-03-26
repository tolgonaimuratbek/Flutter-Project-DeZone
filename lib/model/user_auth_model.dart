//User model
class UserModel {
  String? uid;
  String? email;
  String? userName;

  UserModel({this.uid, this.email, this.userName});

  //receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      userName: map['name'],
    );
  }

  //sending data to the server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': userName,
    };
  }

  //receiving data from firebase
  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    userName = json['name'];
  }

  //sending data from firebase
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['email'] = this.email;
    data['userName'] = this.userName;
    return data;
  }
}
