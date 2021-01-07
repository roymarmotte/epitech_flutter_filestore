import 'dart:convert';
import 'dart:math';

import 'package:epitech_flutter_filestore/items/ingredient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dish {
  int id;
  String title;
  String description;
  List<Ingredient> ingredients;
  String img;
  double price;
  int quantity;

  Dish(String title, String description, List<Ingredient> ingredients,
      String img, double price, int quantity) {
    this.id = 0;
    this.title = title;
    this.quantity = quantity;
    this.description = description;
    this.ingredients = ingredients;
    this.img = img;
    this.price = price;
  }

  Dish.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        quantity = json['quantity'],
        description = json['description'],
        ingredients = json['ingredients'],
        img = json['img'],
        price = json['price'];
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'quantity': quantity,
        'description': description,
        'ingredients': ingredients,
        'img': img,
        'price': price
      };

  void changeIngredient(String ingredientToAdd, bool precense) {
    Ingredient newItem = Ingredient(ingredientToAdd, precense);
    int indexIngredient =
        ingredients.indexWhere((element) => element.title == ingredientToAdd);
    ingredients[indexIngredient] = newItem;
  }

  bool isAlreadyExist(List<Dish> actualList, int id) {
    for (var item in actualList) if (item.id == id) return true;
    return false;
  }

  void save() async {
    Random rng = new Random();
    var actualList = await Dish.load();

    do {
      id = rng.nextInt(100);
    } while (isAlreadyExist(actualList, id));

    actualList.add(this);
    actualList.map((e) => e.toJson()).toList();

    final pref = await SharedPreferences.getInstance();
    pref.setString('dish', jsonEncode(actualList));
  }

  static Future<List<Dish>> load() async {
    final pref = await SharedPreferences.getInstance();
    final loaded = pref.getString('dish');
    List<Dish> result = List();

    if (loaded == null) return result;

    var decoded = json.decode(loaded) as List;
    for (var item in decoded) result.add(Dish.fromJson(item));
    return result;
  }

  delete() async {
    var actualList = await Dish.load();
    for (var item in actualList) {
      if (item.id == this.id) {
        actualList.remove(item);
        break;
      }
    }
    actualList.map((e) => e.toJson()).toList();

    final pref = await SharedPreferences.getInstance();
    pref.setString('dish', jsonEncode(actualList));
  }
}
