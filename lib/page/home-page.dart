import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:epitech_flutter_filestore/page/profile-page.dart';
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

  final routeList = <Widget>[
    HomePage(),
    ProfilePage(),
  ];

  void searchButtonRoad() {}

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
                  controller: _searchBarController,
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
                  'Choose a Categorie:',
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
          ...filterDishes(_searchBarController.text)
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()))
        ,
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
