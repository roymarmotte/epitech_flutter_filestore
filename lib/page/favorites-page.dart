import 'dart:io';
import 'package:epitech_flutter_filestore/components/dishComponent.dart';
import 'package:epitech_flutter_filestore/data/dishes_data.dart';
import 'package:epitech_flutter_filestore/items/dish.dart';
import 'package:flutter/foundation.dart';
import 'package:epitech_flutter_filestore/items/user.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage({Key key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  listFavorites(List<Dish> favorites) {
    List<Widget> widgetDish = favorites.map((e) => DishComponent(e)).toList();
    return widgetDish;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: new Center(
              child: Text(
            "Favorites",
            textAlign: TextAlign.center,
          )),
        ),
        body: FutureBuilder(
          future: User.load(),
          builder: (context, AsyncSnapshot<User> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[...listFavorites(snapshot.data.favorites)],
              );
            } else if (snapshot.hasError) {
              print("error");
              return SnackBar(content: Text('${snapshot.error}'));
            } else {
              return SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              );
            }
          },
        ));
  }
}
