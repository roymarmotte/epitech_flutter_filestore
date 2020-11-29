import 'package:epitech_flutter_filestore/components/dishComponent.dart';
import 'package:epitech_flutter_filestore/items/dish.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _bottomNavIndex = 0;
  final iconList = <IconData>[
    Icons.home,
    Icons.account_circle_outlined,
    Icons.shopping_basket_outlined,
  ];

  void shoppingBasketRoad() {
    print("Shopping basket icon clicked !");
  }

  void searchButtonRoad() {}

  @override
  Widget build(BuildContext context) {
    List<Dish> initialDish = [
      Dish(
          "Omelette au fromage",
          "Dish made from beaten eggs, fried with butter or oil in a frying pan.",
          List(),
          "https://www.canalvie.com/polopoly_fs/1.8675792!/image/Omelette%20fromage.jpg_gen/derivatives/cvlandscape_499_281/Omelette%20fromage.jpg",
          8.00),
      Dish(
          "Welsh",
          " Le Welsh is basically cheese on toast, but with a few added extras - depending on where you are - like beer, mustard or ham.",
          List(),
          "https://img.cuisineaz.com/660x660/2019-08-08/i149772-welsh-au-thermomix.jpeg",
          9.20),
    ];
    List<Widget> widgetDish = initialDish.map((e) => DishComponent(e)).toList();

    return Scaffold(
      appBar: AppBar(
        title: new Center(
          child: Text(
            "Restaurant Delivery",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width * 0.80,
                height: MediaQuery.of(context).size.height *
                    0.10, //MediaQuery.of(context).size.height % 10,
                child: TextField(
                  autocorrect: false,
                  decoration: InputDecoration(
                      hintText: "Search a dish or an entrée...",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90))),
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 50.0),
                child: Text(
                  'Choose a Categorie :',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.80,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Wrap(
                      spacing: 10,
                      children: <Widget>[
                        Chip(label: const Text("Entrée")),
                        Chip(label: const Text("Plat Chauds")),
                        Chip(label: const Text("Plats Froids")),
                        Chip(label: const Text("Desserts"))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          ...widgetDish,
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
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }
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
