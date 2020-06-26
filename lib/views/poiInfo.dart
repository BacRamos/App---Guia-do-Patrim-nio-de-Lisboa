import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpleasymode/Widgets/appbar.dart';
import 'package:gpleasymode/models/API.dart';
import 'package:gpleasymode/models/Comments.dart';
import 'package:gpleasymode/models/POI.dart';
import 'package:gpleasymode/models/User.dart';

class POIInfo extends StatefulWidget {
  final POI data;
  final User user;
  POIInfo(this.data, this.user);

  @override
  _POIInfoState createState() => _POIInfoState();
}

class _POIInfoState extends State<POIInfo> {
  final commentController = TextEditingController();

  bool _loading;
  List<User> users;

  List<int> _options = [1, 2, 3, 4, 5];
  int _selectedOption;
  List<DropdownMenuItem<int>> _dropdownMenuItems;

  List<DropdownMenuItem<int>> buildDropdownMenuItems(List list) {
    List<DropdownMenuItem<int>> items = List();
    for (var item in list) {
      items.add(
        DropdownMenuItem(
          value: item,
          child: Text(item.toString()),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(int selectedOption) {
    setState(() {
      _selectedOption = selectedOption;
    });
  }

  GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    _getUsers();
    _dropdownMenuItems = buildDropdownMenuItems(_options);
    _selectedOption = _dropdownMenuItems[0].value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(widget.user),
      body: ListView(
        children: <Widget>[
          Container(
            height: 250,
            child: Swiper(
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: widget.data.img.isEmpty
                      ? 'https://i.imgur.com/nFZl19F.png'
                      : widget.data.img[index],
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              itemCount: widget.data.img.isEmpty ? 1 : widget.data.img.length,
              pagination: SwiperPagination(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.data.name,
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
                      widget.data.rating.toStringAsFixed(2),
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
                      widget.data.comments.length.toString(),
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
                  widget.data.address,
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  'Descrição',
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text(
                  widget.data.description,
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
                ),
                SizedBox(height: 20),
                Text(
                  'Classificar',
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(height: 20),
                Center(
                    child: DropdownButton(
                        value: _selectedOption,
                        items: _dropdownMenuItems,
                        onChanged: onChangeDropdownItem)),
                SizedBox(height: 20),
                Center(
                  child: RaisedButton(
                    child: Text('SUBMIT'),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      API().postRating(_selectedOption, widget.data.idPoi,
                          widget.user.idUser);
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Atenção"),
                                content:
                                    Text("Obrigado pela sua classificação!"),
                              ));
                    },
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Comentários',
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: commentController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Insira o seu comentário'),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: RaisedButton(
                    child: Text('SUBMIT'),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      API().postComment(Comment(
                          comment: commentController.text,
                          poiID: widget.data.idPoi,
                          userID: widget.user.idUser));
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Atenção"),
                                content: Text("Obrigado pelo seu comentário!"),
                              ));
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.data.comments.isEmpty
                      ? 0
                      : widget.data.comments.length,
                  itemBuilder: (context, index) {
                    if (!widget.data.comments.isEmpty) {
                      return Card(
                        child: Container(
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(_getUserFromID(
                                      widget.data.comments[index].userID) +
                                  ' comentou:'),
                              SizedBox(
                                height: 10,
                              ),
                              Text(widget.data.comments[index].comment)
                            ],
                          ),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget googleMaps() {
    Set<Marker> _markers = Set();

    Marker poiMarker = Marker(
        markerId: MarkerId(widget.data.name),
        infoWindow: InfoWindow(title: widget.data.name),
        position: LatLng(double.parse(widget.data.latitude),
            double.parse(widget.data.longitude)));
    _markers.add(poiMarker);

    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
          target: LatLng(double.parse(widget.data.latitude),
              double.parse(widget.data.longitude)),
          zoom: 11.0),
      markers: _markers,
    );
  }

  String _getUserFromID(int id) {
    for (var user in users) {
      if (user.idUser == id) {
        return user.name;
      }
    }
  }

  _getUsers() async {
    setState(() {
      _loading = true;
    });

    users = await API().getAllUsers();

    setState(() {
      _loading = false;
    });
  }
}
