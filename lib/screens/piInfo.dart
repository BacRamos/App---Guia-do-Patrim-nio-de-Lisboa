import 'package:flutter/material.dart';

class PIScreen extends StatelessWidget {
  final String name;
  final String description;
  final String image;

  PIScreen({
    @required this.name,
    @required this.description,
    @required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Teste'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Image.network(
                  image,
                  height: 300.0,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                name,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                description,
              ),
            ],
          ),
        ));
  }
}
