import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:gpl/screens/piInfo.dart';

var list = [
  {
    'img':
        'https://images.unsplash.com/photo-1502447533750-9860c1269ae3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80',
    'title':
        'This is the 1st title and this is a test to see if the text goes down',
    'desc':
        'This is the description for the 1st point of interest. \nThis will be the place for all the information regarding the selected PI. \nThe Address will also be here.'
  },
  {
    'img':
        'https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60',
    'title': 'This is the 2nd title',
    'desc':
        'This is the description for the 1st point of interest. \nThis will be the place for all the information regarding the selected PI. \nThe Address will also be here.'
  },
  {
    'img':
        'https://images.unsplash.com/photo-1503864664483-e8a499e2eb22?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=856&q=80',
    'title': 'This is the 3rd title',
    'desc':
        'This is the description for the 1st point of interest. \nThis will be the place for all the information regarding the selected PI. \nThe Address will also be here.'
  },
  {
    'img':
        'https://images.unsplash.com/photo-1541233349642-6e425fe6190e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1275&q=80',
    'title': 'This is the 4rd title',
    'desc':
        'This is the description for the 1st point of interest. \nThis will be the place for all the information regarding the selected PI. \nThe Address will also be here.'
  },
];

class CardStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      child: Swiper(
        autoplay: false,
        loop: true,
        pagination: SwiperPagination(
          alignment: Alignment.topCenter,
          builder: DotSwiperPaginationBuilder(
              color: Theme.of(context).accentColor,
              activeColor: Theme.of(context).primaryColor),
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
              margin: EdgeInsets.only(top: 50.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    list[index]['img'],
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: Text(
                      list[index]['title'],
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).backgroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: ButtonTheme(
                      minWidth: 150.0,
                      height: 36.0,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PIScreen(
                                name: list[index]['title'],
                                description: list[index]['desc'],
                                image: list[index]['img'],
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Detalhes',
                          style: TextStyle(
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ));
        },
        itemCount: list.length,
        //itemWidth: 300.0,
        //itemHeight: 400.0,
        viewportFraction: 0.8,
        scale: 0.8,
        //layout: SwiperLayout.STACK,
      ),
    );
  }
}
