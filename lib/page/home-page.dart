import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:epitech_flutter_filestore/components/dishComponent.dart';
import 'package:epitech_flutter_filestore/data/dishes_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchBarController;

  void initState() {
    super.initState();
    _searchBarController = TextEditingController();
  }

  void dispose() {
    _searchBarController.dispose();
    super.dispose();
  }

  var _bottomNavIndex = 0;
  final iconList = <IconData>[
    Icons.home,
    Icons.account_circle_outlined,
    Icons.shopping_basket_outlined,
  ];

  final routeList = <String>["/", "/profile", "/cart"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Your Restaurant Delivery App"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[350],
            ),
            child: TextField(
              controller: _searchBarController,
              autocorrect: false,
              maxLines: 1,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  hintText: "Search a dish or an entrée...",
                  hintStyle: TextStyle(color: Colors.black87),
                  prefixIcon: Icon(Icons.search, color: Colors.black87),
                  border: InputBorder.none),
            ),
          ),
          filterDishes(_searchBarController.text, context)
        ],
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _bottomNavIndex,
        activeColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
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

Container filterDishes(String searchBarText, BuildContext context) {
  var filtredDishes = initialDish.where((element) =>
      element.title.toLowerCase().contains(searchBarText.toLowerCase()));
  List<Widget> widgetDish = filtredDishes.map((e) => DishComponent(e)).toList();

  return Container(
    height: MediaQuery.of(context).size.height * 0.69,
    width: MediaQuery.of(context).size.width,
    child: ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: widgetDish.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(color: Colors.white),
        itemBuilder: (BuildContext context, int index) {
          return widgetDish[index];
        }),
  );
}
