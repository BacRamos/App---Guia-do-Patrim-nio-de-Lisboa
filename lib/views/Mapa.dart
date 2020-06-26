import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpleasymode/Widgets/appbar.dart';
import 'package:gpleasymode/models/API.dart';
import 'package:gpleasymode/models/POI.dart';
import 'package:gpleasymode/models/User.dart';

class Mapa extends StatefulWidget {
  final User user;
  Mapa(this.user);

  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  List<POI> data = List<POI>();
  bool _loading = true;

  Position userPosition;

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
      body: Container(
        child: googleMaps(),
      ),
    );
  }

  _getPOIs() async {
    setState(() {
      _loading = true;
    });

    data = await API().getAllPOI();
    Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    userPosition = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _loading = false;
    });
  }

  Widget googleMaps() {
    Set<Marker> _markers = Set();

    for (var poi in data) {
      Marker poiMarker = Marker(
          markerId: MarkerId(poi.name),
          infoWindow: InfoWindow(title: poi.name),
          position:
              LatLng(double.parse(poi.latitude), double.parse(poi.longitude)));
      _markers.add(poiMarker);
    }

    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
          target: LatLng(userPosition.latitude, userPosition.longitude),
          zoom: 11.0),
      markers: _markers,
    );
  }
}
