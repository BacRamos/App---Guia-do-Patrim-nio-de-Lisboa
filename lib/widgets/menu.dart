import 'package:flutter/material.dart';
import 'package:gpl/screens/allPI.dart';
import 'package:gpl/screens/proximidade.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            child: ListTile(
              title: Text('Mostrar todos os PI\'s'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowAll(),
                  ),
                );
              },
            ),
          ),
          ListTile(
            title: Text('Proximidade'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Proximidade(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Meu itinerário'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('Favoritos'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
