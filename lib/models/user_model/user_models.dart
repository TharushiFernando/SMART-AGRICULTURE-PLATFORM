class UserModels {
  String? uid;
  String? email;
  String? username;
  String? phoneNumber;

  UserModels({this.uid, this.email, this.username, this.phoneNumber});

  factory UserModels.fromJson(Map<String, dynamic> json) {
    return UserModels(
      uid: json['uid'],
      email: json['email'],
      username: json['username'],
      phoneNumber: json['phoneNumber'],
    );
  }
}