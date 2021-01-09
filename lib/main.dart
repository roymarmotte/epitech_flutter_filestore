import 'package:flutter/material.dart';
import 'package:epitech_flutter_filestore/page/home-page.dart';
import 'package:epitech_flutter_filestore/page/profile-page.dart';
import 'package:epitech_flutter_filestore/page/cart-page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Restaurant Delivery Application',
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Color.fromRGBO(233, 47, 72, 1),

          // app bar theme
          appBarTheme: AppBarTheme(
            elevation: 0,
          ),

          // font theme
          fontFamily: "SFProDisplay", // apply by default
          textTheme: TextTheme(
            // SFProDisplay Headline Title
            headline1: TextStyle(
              fontSize: 40,
              color: Color.fromRGBO(66, 66, 66, 1),
              fontWeight: FontWeight.bold,
            ),
            // BluuSuuperstar Headline Title
            headline2: TextStyle(
              fontSize: 40,
              letterSpacing: -0.08,
              color: Color.fromRGBO(66, 66, 66, 1),
              fontFamily: 'BluuSuuperstar',
              fontWeight: FontWeight.bold,
            ),
            // SFProDisplay Subtitle (dish page for ex.)
            subtitle1: TextStyle(
              fontSize: 15,
              letterSpacing: -0.08,
              color: Color.fromRGBO(126, 131, 137, 1),
            ),
            bodyText2: TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(65, 65, 65, 1),
            ),
          )),
      routes: {
        '/': (context) => HomePage(),
        '/dish': (context) => ProfilePage(),
        '/profile': (context) => ProfilePage(),
        '/cart': (context) => CartPage()
      },
    );
  }
}
