import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gpl/models/api.dart';
import 'package:gpl/models/poi.dart';
import 'package:gpl/services/apiService.dart';
import 'package:gpl/views/poiInfo.dart';
import 'package:gpl/widgets/appbar.dart';

class ShowAllPOI extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ShowAllPOI> {
  APIService get service => GetIt.I<APIService>();
  APIResponse<List<POI>> _api;
  bool _isLoading = false;

  @override
  void initState() {
    _fetchPOI();
    super.initState();
  }

  _fetchPOI() async {
    setState(() {
      _isLoading = true;
    });

    _api = await service.getPOIList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        body: Builder(builder: (_) {
          if (_isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (_api.error) {
            return Center(
              child: Text('An error has occured!'),
            );
          }

          return Container(
            child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.black,
                      height: 2,
                    ),
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          _,
                          MaterialPageRoute(
                              builder: (_) => POIInfo(_api.data[index])));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: ListTile(
                        leading: Container(
                          width: 70,
                          height: 70,
                          color: Colors.black,
                          child: CachedNetworkImage(
                            imageUrl: _api.data[index].poiImgUrl.isEmpty
                                ? 'https://i.imgur.com/nFZl19F.png'
                                : _api.data[index].poiImgUrl[0],
                            fit: BoxFit.fill,
                            placeholder: (_, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (_, url, error) => Center(
                              child: Icon(Icons.error),
                            ),
                          ),
                        ),
                        title: Text(_api.data[index].poiName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //Text(_api.data[index].poiAddress.toString()),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(_api.data[index]
                                    .getRating()
                                    .toStringAsFixed(2)),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.thumb_up,
                                  size: 17,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text('TODO'),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.comment,
                                  size: 17,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(_api.data[index].poiComments.length
                                    .toString()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: _api.data.length),
          );
        }));
  }
}
