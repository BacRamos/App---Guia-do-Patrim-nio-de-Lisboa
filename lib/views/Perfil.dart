import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gpleasymode/Widgets/appbar.dart';
import 'package:gpleasymode/models/API.dart';
import 'package:gpleasymode/models/User.dart';

class Perfil extends StatefulWidget {
  final User user;
  Perfil(this.user);

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  int ratingCount, commentCount;

  @override
  void initState() {
    _getUserRatings().then((val) => setState(() {
          ratingCount = val;
        }));
    _getUserComments().then((val) => setState(() {
          commentCount = val;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(widget.user),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: 400,
            color: Colors.orange[800],
            child: Center(
              child: Container(
                height: 150,
                width: 150,
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 71.0,
                    backgroundImage: NetworkImage(widget.user.img == null
                        ? 'https://i.imgur.com/8pfRYX7.png'
                        : widget.user.img),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Nome: ',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                widget.user.name,
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Email: ',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                widget.user.email,
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'País: ',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                widget.user.country,
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    ratingCount.toString(),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    'Ratings',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
              SizedBox(
                width: 50,
              ),
              Column(
                children: <Widget>[
                  Text(
                    commentCount.toString(),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    'Comentários',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _getUserRatings() async {
    return await API().getRatingsFromUser(widget.user.idUser);
  }

  _getUserComments() async {
    return await API().getCommentsFromUser(widget.user.idUser);
  }
}
