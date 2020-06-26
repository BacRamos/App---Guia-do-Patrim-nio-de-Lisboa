import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:gpleasymode/Widgets/appbar.dart';
import 'package:gpleasymode/models/API.dart';
import 'package:gpleasymode/models/POI.dart';
import 'package:gpleasymode/models/User.dart';
import 'package:gpleasymode/views/POIInfo.dart';

class Recommended extends StatefulWidget {
  final User user;
  Recommended(this.user);

  @override
  _RecommendedState createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  List<POI> data = List<POI>();
  bool _loading = true;

  @override
  void initState() {
    _getPOIs().then((val) => setState(() {
          data = val;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(widget.user),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Text('Recomendados', style: Theme.of(context).textTheme.headline2),
            SizedBox(height: 30),
            Container(
              height: 500,
              child: Swiper(
                itemCount: 5,
                layout: SwiperLayout.STACK,
                itemWidth: 350.0,
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
                    child: CachedNetworkImage(
                      imageUrl: data[index].img.isEmpty
                          ? 'https://i.imgur.com/nFZl19F.png'
                          : data[index].img[0],
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _getPOIs() async {
    data = await API().getAllPOI();
    data.sort((b, a) => a.rating.compareTo(b.rating));
    return data.sublist(0, 5);
  }
}
