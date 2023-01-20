import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.userId,
    required this.name,
    required this.imageUrl,
    required this.phoneNumber,
    required this.userUid,
    required this.some,
  });

  String userId;
  String name;
  String imageUrl;
  String phoneNumber;
  String userUid;
  String some;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: json["user_id"],
    name: json["name"],
    imageUrl: json["image_url"],
    phoneNumber: json["phone_number"],
    userUid: json["user_uid"],
    some: json["some"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "image_url": imageUrl,
    "phone_number": phoneNumber,
    "user_uid": userUid,
    "some": some,
  };
}
