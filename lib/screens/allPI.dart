import 'package:flutter/material.dart';
import 'package:gpl/screens/piInfo.dart';
import 'package:gpl/widgets/menu.dart';
import 'package:gpl/widgets/search.dart';
import 'package:gpl/widgets/cardStack.dart';

class ShowAll extends StatelessWidget {
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
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return cardTemplate(
            img: list[index]['img'],
            title: list[index]['title'],
            desc: list[index]['desc'],
            context: context,
          );
        },
      ),
    );
  }

  Widget cardTemplate({
    @required String img,
    @required String title,
    @required String desc,
    @required var context,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      child: Container(
        height: 150,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PIScreen(
                  name: title,
                  description: desc,
                  image: img,
                ),
              ),
            );
          },
          child: Card(
            color: Theme.of(context).accentColor,
            elevation: 10,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        img,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*
 ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            height: 150.0,
            margin: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: ListTile(
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 150.0,
                  minWidth: 150.0,
                  maxHeight: 150.0,
                  maxWidth: 150.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      image: NetworkImage(
                        list[index]['img'],
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              title: Text('Teste'),
            ),
          );
        },
      ), */
