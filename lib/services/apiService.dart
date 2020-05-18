import 'dart:convert';
import 'package:gpl/models/api.dart';
import 'package:gpl/models/poi.dart';
import 'package:gpl/models/user.dart';
import 'package:http/http.dart' as http;

class APIService {
  static const API = 'http://patrimonioculturaldelisboa.herokuapp.com/api';

  Future<APIResponse<List<POI>>> getPOIList() async {
    final responseLocation = await http.get('$API/POI/location');
    final responseRating = await http.get('$API/POI/ratings');
    final responseImages = await http.get('$API/POI/img');
    final List<POI> data = <POI>[];

    //Get Location API
    if (responseLocation.statusCode == 200) {
      final locationData = json.decode(responseLocation.body);
      for (var item in locationData) {
        data.add(POI.fromJson(item));
      }
    } else {
      return APIResponse<List<POI>>(
          error: true, errorMessage: 'An error occurred!');
    }

    //Get rating API
    if (responseRating.statusCode == 200) {
      final ratingData = json.decode(responseRating.body);

      for (var item in ratingData) {
        //index da lista data onde o idPOI é igual ao POI_idPOI do ratingData
        var index = data.indexWhere((i) => i.poiID == item['POI_idPOI']);
        data[index].poiRatingList.add(item['rating'].toDouble());
      }
    } else {
      return APIResponse<List<POI>>(
          error: true, errorMessage: 'An error occurred!');
    }

    //Get images API
    if (responseImages.statusCode == 200) {
      final imagesData = json.decode(responseImages.body);

      for (var item in imagesData) {
        //index da lista data onde o idPOI é igual ao POI_idPOI do imagesData
        var index = data.indexWhere((i) => i.poiID == item['POI_idPOI']);
        data[index].poiImgUrl.add(item['url']);
      }
    } else {
      return APIResponse<List<POI>>(
          error: true, errorMessage: 'An error occurred!');
    }

    return APIResponse<List<POI>>(data: data);
  }

  Future<APIResponse<User>> getUsers(int id) async {
    final responseUser = await http.get('$API/users/info');
    User data;

    if (responseUser.statusCode == 200) {
      final userData = json.decode(responseUser.body);
      for (var item in userData) {
        if (id == item['idUser']) {
          data = User.fromJson(item);
        }
      }
    } else {
      return APIResponse<User>(error: true, errorMessage: 'An error occurred!');
    }

    return APIResponse<User>(data: data);
  }

  Future<APIResponse<int>> getIdFromEmail(String email) async {
    final responseUser = await http.get('$API/users/info');
    int userID;

    if (responseUser.statusCode == 200) {
      final userData = json.decode(responseUser.body);
      for (var item in userData) {
        if (email == item['email']) {
          userID = item['idUser'];
        }
      }
    } else {
      return APIResponse<int>(error: true, errorMessage: 'An error occurred!');
    }

    return APIResponse<int>(data: userID);
  }
}
