import 'package:flutter/material.dart';
import 'package:gpleasymode/views/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      theme: ThemeData(
          primaryColor: Colors.orange[800],
          secondaryHeaderColor: Colors.orange[400],
          accentColor: Colors.white,
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 72.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Jost',
            ),
            headline2: TextStyle(
              fontSize: 36.0,
              color: Colors.black,
              fontFamily: 'Jost',
            ),
            headline3: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontFamily: 'Jost',
            ),
            headline4: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontFamily: 'Jost',
            ),
            headline5: TextStyle(
              fontSize: 36.0,
              color: Colors.orange[800],
              fontFamily: 'Jost',
            ),
            bodyText1: TextStyle(
              fontSize: 14.0,
              color: Colors.grey[700],
              fontFamily: 'Jost',
            ),
            bodyText2: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontFamily: 'Jost',
            ),
          )),
    );
  }
}
