import 'dart:ui';

import 'package:epitech_flutter_filestore/items/dish.dart';
import 'package:epitech_flutter_filestore/items/user.dart';
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
  IconData star;
  Dish dish;

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
    if (dish == null) dish = widget.dish;
    return FutureBuilder<User>(
        future: User.load(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.isAlreadyFavs(dish.id))
              star = Icons.star;
            else
              star = Icons.star_border;

            return Scaffold(
              appBar: AppBar(),
              body: ListView(
                padding: EdgeInsets.all(20),
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          dish.title,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: Icon(star, color: Colors.yellow, size: 50.0),
                          onTap: () {
                            setState(() {
                              if (snapshot.data.isAlreadyFavs(dish.id)) {
                                snapshot.data.deleteFavs(dish);
                              } else
                                dish = snapshot.data.saveFavs(dish);
                              snapshot.data.save();
                            });
                          },
                        ),
                        flex: 1,
                      )
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 8, bottom: 20),
                      child: Text(
                        dish.description,
                        style: Theme.of(context).textTheme.subtitle1,
                      )),
                  Container(
                    child: Image.network(dish.img),
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
                  displayIngredients(dish.ingredients),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (dish.quantity < 1)
                                      dish.quantity = 1;
                                    dish.quantity -= 1;
                                  });
                                },
                                child: Text(
                                  "-",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                              SizedBox(width: 23),
                              Text(
                                dish.quantity.toString(),
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              SizedBox(width: 23),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    dish.quantity += 1;
                                  });
                                },
                                child: Text(
                                  "+",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Theme.of(context).primaryColor,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                dish.save();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 60, vertical: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.transparent),
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
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
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
        });
  }
}
