import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Guia do Património de Lisboa'),
      backgroundColor: Theme.of(context).primaryColor,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: <Widget>[
        DrawerHeader(
          child: Text('Hello'),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
        ),
        ListTile(
          title: Text(
            'Principal',
            style: Theme.of(context).textTheme.headline3,
          ),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            'Todos',
            style: Theme.of(context).textTheme.headline3,
          ),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            'Itinerário',
            style: Theme.of(context).textTheme.headline3,
          ),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            'Proximidade',
            style: Theme.of(context).textTheme.headline3,
          ),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            'Favoritos',
            style: Theme.of(context).textTheme.headline3,
          ),
          onTap: () {},
        ),
        SizedBox(
          height: 20,
        ),
        ListTile(
          title: Text(
            'Perfil',
            style: Theme.of(context).textTheme.headline3,
          ),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            'Sign In/Sign Out',
            style: Theme.of(context).textTheme.headline3,
          ),
          onTap: () {},
        ),
      ]),
    );
  }
}
