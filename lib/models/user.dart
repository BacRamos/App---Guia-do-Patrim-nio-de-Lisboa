import 'package:flutter/material.dart';

class User {
  int userID;
  String userName;
  String userEmail;
  String userPassword;
  double userLat;
  double userLon;
  String userImg;

  User({
    this.userEmail,
    this.userID,
    this.userImg,
    this.userLat,
    this.userLon,
    this.userName,
    this.userPassword,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userEmail: json['email'],
      userID: json['idUser'] as int,
      userImg: json['img'],
      userName: json['name'],
      userPassword: json['password'],
    );
  }
}
