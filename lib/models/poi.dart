import 'package:geocoder/geocoder.dart';

class POI {
  int poiID;
  String poiName;
  double poiLon;
  double poiLat;
  String poiDesc;
  String poiAddress;
  List<String> poiImgUrl;
  double poiRating;
  List<double> poiRatingList;
  List<String> poiComments;

  POI({
    this.poiID,
    this.poiDesc,
    this.poiLat,
    this.poiLon,
    this.poiName,
  }) {
    this.poiImgUrl = [];
    this.poiRatingList = [];
    this.poiComments = [];
    getAddress();
  }

  factory POI.fromJson(Map<String, dynamic> json) {
    return POI(
      poiName: json['name'],
      poiLon: double.parse(json['longitude']),
      poiLat: double.parse(json['latitude']),
      poiID: json['idPOI'],
      poiDesc: json['description'],
    );
  }

  double getRating() {
    double count = 0.0;
    for (var item in this.poiRatingList) {
      count += item;
    }
    this.poiRating = count / poiRatingList.length;
    return poiRating;
  }

  getAddress() async {
    try {
      List<Address> p = await Geocoder.local
          .findAddressesFromCoordinates(Coordinates(this.poiLat, this.poiLon));
      this.poiAddress = "${p.first.addressLine}";
    } catch (e) {
      print(e);
    }
  }
}
