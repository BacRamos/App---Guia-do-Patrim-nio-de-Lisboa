import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gpleasymode/Widgets/appbar.dart';
import 'package:gpleasymode/models/API.dart';
import 'package:gpleasymode/models/POI.dart';
import 'package:gpleasymode/models/User.dart';
import 'package:gpleasymode/views/POIInfo.dart';

class Proximidade extends StatefulWidget {
  final User user;
  Proximidade(this.user);

  @override
  _ProximidadeState createState() => _ProximidadeState();
}

class _ProximidadeState extends State<Proximidade> {
  List<POI> data;
  bool _loading = true;

  @override
  void initState() {
    _getPOIs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(widget.user),
      body: Builder(
        builder: (context) {
          if (_loading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
            );
          }

          return Container(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return POIInfo(data[index], widget.user);
                      }),
                    );
                  },
                  child: Card(
                    child: Container(
                      height: 100,
                      child: Row(
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl: data[index].img.isEmpty
                                ? 'https://i.imgur.com/nFZl19F.png'
                                : data[index].img[0],
                            imageBuilder: (context, image) => Container(
                              margin: EdgeInsets.symmetric(horizontal: 8.0),
                              width: 150.0,
                              height: 90.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(data[index].name),
                                Text(
                                    'Distância - ${data[index].distance.toString()} km')
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  _getPOIs() async {
    setState(() {
      _loading = true;
    });

    data = await API().getAllPOI();

    Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    Position userPosition = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    for (var poi in data) {
      double distance = await Geolocator().distanceBetween(
              userPosition.latitude,
              userPosition.longitude,
              double.parse(poi.latitude),
              double.parse(poi.longitude)) /
          1000;
      String dist = distance.toStringAsFixed(2);
      distance = double.parse(dist);
      poi.postDistance(distance);
    }

    data.sort((a, b) => a.distance.compareTo(b.distance));

    setState(() {
      _loading = false;
    });
  }
}
