import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:epitech_flutter_filestore/components/cartComponent.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:epitech_flutter_filestore/items/dish.dart';
import 'package:epitech_flutter_filestore/items/user.dart';
import 'package:audioplayer/audioplayer.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var _bottomNavIndex = 2;
  AudioPlayer audio = AudioPlayer();
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
          future: User.load(),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.cart.isEmpty) {
                return Column();
              } else {
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.50,
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: ListView(
                        padding: const EdgeInsets.all(8),
                        children: [
                          CartComponent(value: snapshot.data.cart.first)
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          snapshot.data.cleanCart();
                          audio.play("../../sounds/success.mp3");

                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.10,
                        width: MediaQuery.of(context).size.width * 1,
                        color: Colors.green,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Icon(Icons.star)],
                        ),
                      ),
                    )
                  ],
                );
              }
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
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: iconList,
          activeIndex: _bottomNavIndex,
          backgroundColor: Theme.of(context).primaryColor,
          gapLocation: GapLocation.none,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          leftCornerRadius: 0,
          rightCornerRadius: 0,
          onTap: (index) =>
              Navigator.pushReplacementNamed(context, routeList[index]),
        ));
  }
}
