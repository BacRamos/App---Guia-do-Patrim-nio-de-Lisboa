import 'package:flutter/material.dart';
import 'package:gpl/widgets/cardStack.dart';
import 'package:gpl/widgets/menu.dart';
import 'package:gpl/widgets/search.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            iconSize: 30.0,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('GPL'),
              Search(),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              'Recomendados',
              style: TextStyle(fontSize: 36),
            ),
          ),
          CardStack(),
        ],
      ),
    );
  }
}
