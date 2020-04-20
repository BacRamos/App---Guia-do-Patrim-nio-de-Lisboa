import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      alignment: Alignment.centerRight,
      icon: Icon(Icons.search),
      color: Theme.of(context).backgroundColor,
      onPressed: () {
        showSearch(
          context: context,
          delegate: DataSearch(),
        );
      },
      iconSize: 30.0,
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final cities = ['Lisboa', 'Porto', 'Braga', 'Aveiro', 'Faro'];
  final recentsCities = ['Lisboa', 'Porto'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for the appBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left of the appBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show some result based on the selection
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show when someone searches for something
    final suggestionList = query.isEmpty
        ? recentsCities
        : cities.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.location_city),
        title: Text(suggestionList[index]),
      ),
      itemCount: suggestionList.length,
    );
  }
}
