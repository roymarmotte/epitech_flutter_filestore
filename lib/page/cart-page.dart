import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:epitech_flutter_filestore/components/cartComponent.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:epitech_flutter_filestore/page/home-page.dart';
import 'package:epitech_flutter_filestore/items/dish.dart';
import 'package:epitech_flutter_filestore/items/ingredient.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var _bottomNavIndex = 2;
  final iconList = <IconData>[
    Icons.home,
    Icons.account_circle_outlined,
    Icons.shopping_basket_outlined,
  ];
  final routeList = <String>["/", "/profile", "/cart"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Center(
            child: Text(
              "Restaurant Delivery",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: FutureBuilder(
          future: Dish.load(),
          builder: (BuildContext context, AsyncSnapshot<Dish> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.50,
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: ListView(
                      padding: const EdgeInsets.all(8),
                      children: [CartComponent(value: snapshot.data)],
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              print("woops");
              return null;
            } else {
              return SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              );
            }
          },
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
        ));
  }
}
