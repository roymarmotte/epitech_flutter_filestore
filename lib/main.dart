import 'package:flutter/material.dart';
import 'package:epitech_flutter_filestore/page/home-page.dart';
import 'package:epitech_flutter_filestore/page/profile-page.dart';
import 'package:epitech_flutter_filestore/page/cart-page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Delivery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {'/': (context) => HomePage(), '/dish': (context) => ProfilePage(), '/profile': (context) => ProfilePage(), '/cart': (context) => CartPage()},
    );
  }
}
