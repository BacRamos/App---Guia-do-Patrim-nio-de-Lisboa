import 'package:flutter/material.dart';
import 'package:gpleasymode/models/User.dart';
import 'package:gpleasymode/views/Mapa.dart';
import 'package:gpleasymode/views/POIView.dart';
import 'package:gpleasymode/views/Perfil.dart';
import 'package:gpleasymode/views/Proximidade.dart';
import 'package:gpleasymode/views/Recommended.dart';
import 'package:gpleasymode/views/login.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Guia do Património de Lisboa'),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class MyDrawer extends StatelessWidget {
  final User user;
  MyDrawer(this.user);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: <Widget>[
        DrawerHeader(
          child: Column(
            children: <Widget>[
              Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(user.img == null
                        ? 'https://i.imgur.com/8pfRYX7.png'
                        : user.img),
                  ),
                ),
              ),
              Text(
                user.name,
                textScaleFactor: 1.5,
                style: Theme.of(context).textTheme.bodyText2,
              )
            ],
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
        ),
        ListTile(
          title: Text(
            'Principal',
            style: Theme.of(context).textTheme.headline3,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Recommended(user),
              ),
            );
          },
        ),
        ListTile(
          title: Text(
            'Todos',
            style: Theme.of(context).textTheme.headline3,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => POIView(user),
              ),
            );
          },
        ),
        ListTile(
          title: Text(
            'Proximidade',
            style: Theme.of(context).textTheme.headline3,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Proximidade(user),
              ),
            );
          },
        ),
        ListTile(
          title: Text(
            'Mapa',
            style: Theme.of(context).textTheme.headline3,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Mapa(user),
              ),
            );
          },
        ),
        SizedBox(
          height: 220,
        ),
        ListTile(
          title: Text(
            'Perfil',
            style: Theme.of(context).textTheme.headline3,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Perfil(user),
              ),
            );
          },
        ),
        ListTile(
          title: Text(
            'Sign Out',
            style: Theme.of(context).textTheme.headline3,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
            );
          },
        ),
      ]),
    );
  }
}
