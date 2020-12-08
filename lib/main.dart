import 'package:flutter/material.dart';
import 'page/home-page.dart';

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
      routes: {'/': (context) => HomePage(), '/dish': (context) => HomePage(), '/profile': (context) => HomePage(), '/basket': (context) => HomePage()},
    );
  }
}
