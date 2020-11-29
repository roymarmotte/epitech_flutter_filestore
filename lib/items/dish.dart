import 'dart:ffi';
import 'dart:io';
import 'package:epitech_flutter_filestore/items/ingredient.dart';
import 'package:flutter/cupertino.dart';

class Dish {
  Float price;
  Image img;
  List<Ingredient> ingredients;
  String title;
  String description;

  Dish(String title, String description, List<Ingredient> ingredient, File img,
      Float price) {
    this.title       = title;
    this.description = description;
    this.img         = Image.file(img);
    this.price       = price;
    this.ingredients = ingredients;
  }

  void changeIngredient(String ingredientToAdd, bool precense) {
    Ingredient newItem  = Ingredient(ingredientToAdd, precense);
    int indexIngredient =
        ingredients.indexWhere((element) => element.title == ingredientToAdd);
    ingredients[indexIngredient] = newItem;
  }
}
