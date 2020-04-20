import 'package:flutter/material.dart';
import 'package:gpl/screens/homeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String appTitle = 'Guia do património de Lisboa';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        accentColor: Colors.indigo[200],
        backgroundColor: Colors.white,
      ),
      home: HomeScreen(),
    );
  }
}
