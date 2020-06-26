import 'dart:convert';
import 'package:gpleasymode/models/Comments.dart';
import 'package:gpleasymode/models/POI.dart';
import 'package:gpleasymode/models/User.dart';
import 'package:http/http.dart' as http;

class API {
  static const BASEURL = 'http://patrimonioculturaldelisboa.herokuapp.com/api';

  Future<List<POI>> getAllPOI() async {
    print("API -> getAllPOI = Loading!");
    final response = await http.get('$BASEURL/POI/location');
    if (response.statusCode == 200) {
      List<POI> data = List<POI>();
      for (var item in jsonDecode(response.body)) {
        POI poi = POI.fromJson(item);

        final response2 = await http.get('$BASEURL/POI/img');
        if (response2.statusCode == 200) {
          for (var item2 in jsonDecode(response2.body)) {
            if (item2['POI_idPOI'] == poi.idPoi) {
              poi.img.add(item2['url']);
            }
          }
        }

        final response3 = await http.get('$BASEURL/POI/Avgrating');
        if (response3.statusCode == 200) {
          for (var item3 in jsonDecode(response3.body)) {
            if (item3['POI_idPOI'] == poi.idPoi) {
              poi.rating = item3['media'];
            }
          }
        }

        final response4 = await http.get('$BASEURL/POI/allcomments');
        if (response4.statusCode == 200) {
          for (var item4 in jsonDecode(response4.body)) {
            if (item4['POI_idPOI'] == poi.idPoi) {
              Comment comment = Comment.fromJson(item4);
              poi.comments.add(comment);
            }
          }
        }

        data.add(poi);
      }
      print("API -> getAllPOI = Success!");
      return data;
    }
    print("API -> getAllPOI = Fail!");
    return null;
  }

  Future<List<User>> getAllUsers() async {
    print("API -> getAllUsers = Loading!");

    final response = await http.get('$BASEURL/users/info');
    List<User> data = List<User>();
    if (response.statusCode == 200) {
      for (var item in jsonDecode(response.body)) {
        data.add(User.fromJson(item));
      }
      print("API -> getAllUsers = Success!");
      return data;
    }
    print("API -> getAllUsers = Fail!");
    return null;
  }

  Future<User> getUser(String email) async {
    print("API -> getUser = Loading!");
    final response = await http.get('$BASEURL/users/$email');

    User user;
    if (response.statusCode == 200) {
      print("API -> getUser = Success!");
      return userFromJson(response.body)[0];
    }

    print("API -> getUser = Fail!");
    return null;
  }

  Future<Comment> postComment(Comment comment) async {
    final response = await http.post('$BASEURL/POI/comentario',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'comment': comment.comment,
          'idUser': comment.userID,
          'idPOI': comment.poiID
        }));
    //print('comment.toJson().toString()');
    if (response.statusCode == 201) {
      return Comment.fromJson(jsonDecode(response.body));
    }
  }

  Future<Comment> postRating(int rating, int poiID, int userID) async {
    final response = await http.post('$BASEURL/POI/rating',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'rating': rating,
          'idPOI': poiID,
          'idUser': userID
        }));
    //print('comment.toJson().toString()');
    if (response.statusCode == 201) {
      return Comment.fromJson(jsonDecode(response.body));
    }
  }

  Future<int> getRatingsFromUser(int id) async {
    print("API -> getRatingsFromUser = Loading!");
    final response = await http.get('$BASEURL/POI/allRatings');

    int count = 0;

    if (response.statusCode == 200) {
      print("API -> getRatingsFromUser = Success!");
      for (var item in jsonDecode(response.body)) {
        if (item['User_idUser'] == id) {
          count++;
        }
      }
      return count;
    }

    print("API -> getRatingsFromUser = Fail!");
    return null;
  }

  Future<int> getCommentsFromUser(int id) async {
    print("API -> getCommentsFromUser = Loading!");
    final response = await http.get('$BASEURL/POI/AllComments');

    int count = 0;

    if (response.statusCode == 200) {
      print("API -> getCommentsFromUser = Success!");
      for (var item in jsonDecode(response.body)) {
        if (item['User_idUser'] == id) {
          count++;
        }
      }
      return count;
    }

    print("API -> getCommentsFromUser = Fail!");
    return null;
  }
}
