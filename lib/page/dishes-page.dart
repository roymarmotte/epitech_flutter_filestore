import 'dart:convert';
import 'dart:ui';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:epitech_flutter_filestore/components/dishComponent.dart';
import 'package:epitech_flutter_filestore/data/dishes_data.dart';
import 'package:epitech_flutter_filestore/items/dish.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DishesPage extends StatefulWidget {
  final Dish dish;
  DishesPage(this.dish);

  @override
  _DishesPageState createState() => _DishesPageState();
}

class _DishesPageState extends State<DishesPage> {
  var _bottomNavIndex = 0;
  final iconList = <IconData>[
    Icons.home,
    Icons.account_circle_outlined,
    Icons.shopping_basket_outlined,
  ];

  final routeList = <String>[
    "/",
    "/profile",
  ];

  @override
  Widget build(BuildContext context) {
    print(widget.dish.ingredients);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Text(
            widget.dish.title,
            style: TextStyle(
              fontSize: 40,
              letterSpacing: -0.08,
              color: Color.fromRGBO(66, 66, 66, 1),
              fontFamily: 'BluuSuuperstar',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 8, bottom: 20),
              child: Text(
                widget.dish.description,
                style: TextStyle(
                  fontSize: 15,
                  letterSpacing: -0.08,
                  color: Color.fromRGBO(126, 131, 137, 1),
                  fontFamily: 'SFProDisplay',
                ),
              )),
          Container(
            child: Image.network(widget.dish.img),
          ),
          /* ListView.builder(
              itemCount: widget.dish.ingredients.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  child: Center(
                      child: Text('Entry ${widget.dish.ingredients[index]}')),
                );
              }) */
        ],
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _bottomNavIndex,
        backgroundColor: HexColor('#4285F4'),
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        onTap: (index) =>
            Navigator.pushReplacementNamed(context, routeList[index]),
      ),
    );
  }
}

filterDishes(String searchBarText) {
  var filtredDishes = initialDish.where((element) =>
      element.title.toLowerCase().contains(searchBarText.toLowerCase()));
  List<Widget> widgetDish = filtredDishes.map((e) => DishComponent(e)).toList();
  return widgetDish;
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
