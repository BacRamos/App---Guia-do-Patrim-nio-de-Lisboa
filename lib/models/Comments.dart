import 'dart:convert';

List<Comment> commentFromJson(String str) =>
    List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
  Comment({
    this.comment,
    this.poiID,
    this.userID,
  });

  String comment;
  int poiID;
  int userID;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        comment: json["comment"],
        poiID: json["POI_idPOI"],
        userID: json["User_idUser"],
      );

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "POI_idPOI": poiID,
        "User_idUser": userID,
      };
}
