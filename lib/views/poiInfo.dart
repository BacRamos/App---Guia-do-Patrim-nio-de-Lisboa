import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:gpl/models/poi.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpl/widgets/appbar.dart';

class POIInfo extends StatefulWidget {
  final POI _poi;
  POIInfo(this._poi);

  @override
  _POIInfoState createState() => _POIInfoState();
}

class _POIInfoState extends State<POIInfo> {
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: ListView(
        children: <Widget>[
          Container(
            height: 250,
            child: Swiper(
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: widget._poi.poiImgUrl.isEmpty
                      ? 'https://i.imgur.com/nFZl19F.png'
                      : widget._poi.poiImgUrl[index],
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              itemCount: widget._poi.poiImgUrl.isEmpty
                  ? 1
                  : widget._poi.poiImgUrl.length,
              pagination: SwiperPagination(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget._poi.poiName,
                  style: Theme.of(context).textTheme.headline2,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      size: 15,
                      color: Colors.grey[800],
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      widget._poi.getRating().toStringAsFixed(2),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.thumb_up,
                      size: 12,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      'TODO',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.comment,
                      color: Colors.grey,
                      size: 12,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      widget._poi.poiComments.length.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Morada',
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text(
                  widget._poi.poiAddress,
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  'Descrição',
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text(
                  widget._poi.poiDesc,
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  'Localização',
                  style: Theme.of(context).textTheme.headline3,
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  child: googleMaps(),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up, color: Colors.blue),
            title: Text('Gosto', style: TextStyle(color: Colors.black)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment, color: Colors.grey),
            title: Text('Comentários', style: TextStyle(color: Colors.black)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star, color: Colors.yellow),
            title: Text(
              'Classificação',
            ),
          ),
        ],
      ),
    );
  }

  Widget googleMaps() {
    Set<Marker> _markers = Set();

    Marker poiMarker = Marker(
        markerId: MarkerId(widget._poi.poiName),
        infoWindow: InfoWindow(title: widget._poi.poiName),
        position: LatLng(widget._poi.poiLat, widget._poi.poiLon));
    _markers.add(poiMarker);

    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
          target: LatLng(widget._poi.poiLat, widget._poi.poiLon), zoom: 11.0),
      markers: _markers,
    );
  }
}
