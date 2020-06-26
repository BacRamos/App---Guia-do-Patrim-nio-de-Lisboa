import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
    User({
        this.idUser,
        this.name,
        this.email,
        this.country,
        this.img,
        this.password,
        this.location,
    });

    int idUser;
    String name;
    String email;
    String country;
    String img;
    String password;
    String location;

    factory User.fromJson(Map<String, dynamic> json) => User(
        idUser: json["idUser"],
        name: json["name"],
        email: json["email"],
        country: json["country"],
        img: json["img"],
        password: json["password"],
        location: json["location"],
    );

    Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "name": name,
        "email": email,
        "country": country,
        "img": img,
        "password": password,
        "location": location,
    };
}
