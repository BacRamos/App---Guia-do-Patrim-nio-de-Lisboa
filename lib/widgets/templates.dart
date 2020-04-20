import 'package:flutter/material.dart';

class Templates {
  Widget cardTemplate(String img) {
    return Card(
      child: Row(
        children: <Widget>[
          Container(
            child: Image.network(img),
          ),
        ],
      ),
    );
  }
}
