import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:epitech_flutter_filestore/components/cartComponent.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:epitech_flutter_filestore/items/dish.dart';
import 'package:epitech_flutter_filestore/items/user.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var _bottomNavIndex = 2;
  List<Dish> toDisplay;
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
          builder: (BuildContext context, AsyncSnapshot<List<Dish>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isEmpty) {
                return Column();
              } else {
                return Column(
                  children: [
                    Expanded(
                        child: FutureBuilder<User>(
                            future: User.load(),
                            builder: (BuildContext context,
                                AsyncSnapshot<User> snapshotUser) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CartComponent(
                                          value: snapshot.data[index]);
                                    });
                              } else
                                return Column();
                            })),
                    InkWell(
                      onTap: () {
                        setState(() {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Order complete !')));
                        });
                      },
                      child: Container(
                        decoration: new BoxDecoration(
                            color: Colors.green,
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(40),
                                bottomLeft: const Radius.circular(40),
                                topRight: const Radius.circular(40),
                                bottomRight: const Radius.circular(40))),
                        height: MediaQuery.of(context).size.height * 0.10,
                        width: MediaQuery.of(context).size.width * 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Text("Order")],
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
