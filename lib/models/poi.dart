import 'dart:convert';

import 'package:geocoder/geocoder.dart';
import 'package:gpleasymode/models/Comments.dart';

List<POI> poiFromJson(String str) =>
    List<POI>.from(json.decode(str).map((x) => POI.fromJson(x)));

class POI {
  int idPoi;
  String name;
  List<String> img;
  String longitude;
  String latitude;
  String address;
  String description;
  double rating;
  List<Comment> comments;
  double distance;

  POI({
    this.idPoi,
    this.name,
    this.img,
    this.longitude,
    this.latitude,
    this.description,
  }) {
    img = List<String>();
    comments = List<Comment>();
    getAddress();
  }

  factory POI.fromJson(Map<String, dynamic> json) => POI(
        idPoi: json["idPOI"] as int,
        name: json["name"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        description: json["description"],
      );

  getAddress() async {
    try {
      List<Address> p = await Geocoder.local.findAddressesFromCoordinates(
          Coordinates(
              double.parse(this.latitude), double.parse(this.longitude)));
      this.address = "${p.first.addressLine}";
    } catch (e) {
      print(e);
    }
  }

  postDistance(double distance) {
    this.distance = distance;
  }
}
