import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gpl/services/apiService.dart';
import 'package:gpl/views/login.dart';
import 'package:gpl/views/showAllPOI.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => APIService());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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
      home: Login(),
    );
  }
}
