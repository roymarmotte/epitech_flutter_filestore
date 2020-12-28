import 'dart:ui';

import 'package:epitech_flutter_filestore/items/dish.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:epitech_flutter_filestore/items/ingredient.dart';

class DishesPage extends StatefulWidget {
  final Dish dish;
  DishesPage(this.dish);

  @override
  _DishesPageState createState() => _DishesPageState();
}

class _DishesPageState extends State<DishesPage> {
  displayIngredients(List<Ingredient> dishIngredients) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding: const EdgeInsets.all(5),
      itemCount: dishIngredients.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            margin: EdgeInsets.only(top: 5),
            child: Text('${dishIngredients[index].title}',
                style: TextStyle(
                  color: Color.fromRGBO(66, 66, 66, 1),
                  fontFamily: "SFProDisplay",
                  fontStyle: FontStyle.normal,
                )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
          Container(
            margin: EdgeInsets.only(top: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ingredients",
                  style: TextStyle(
                    color: Color(0xff414141),
                    fontSize: 20,
                    fontFamily: "SFProDisplay",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  width: 100,
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19),
                    color: Color(0xffe82e47),
                  ),
                ),
              ],
            ),
          ),
          displayIngredients(widget.dish.ingredients),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  height: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xfff0f0f0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "-",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff7e8389),
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(width: 23),
                      Text(
                        "1",
                        style: TextStyle(
                          color: Color(0xff414141),
                          fontSize: 20,
                          fontFamily: "SF Pro Display",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 23),
                      Text(
                        "+",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff7e8389),
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 58,
                  child: Container(
                    width: 225,
                    height: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffe82e47),
                    ),
                    child: Center(
                      child: Text(
                        "Add to cart",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "SFProDisplay",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
