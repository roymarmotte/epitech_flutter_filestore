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
      padding: EdgeInsets.all(5),
      itemCount: dishIngredients.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            margin: EdgeInsets.only(top: 5),
            child: Text('${dishIngredients[index].title}'));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Text(
            widget.dish.title,
            style: Theme.of(context).textTheme.headline2,
          ),
          Container(
              margin: EdgeInsets.only(top: 8, bottom: 20),
              child: Text(
                widget.dish.description,
                style: Theme.of(context).textTheme.subtitle1,
              )),
          Container(
            child: Image.network(widget.dish.img),
          ),
          Container(
            margin: EdgeInsets.only(top: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ingredients",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  width: 100,
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19),
                    color: Theme.of(context).primaryColor,
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xfff0f0f0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "-",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22),
                      ),
                      SizedBox(width: 23),
                      Text(
                        "1",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(width: 23),
                      Text(
                        "+",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor),
                  child: Center(
                    child: Text(
                      "Add to cart",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
