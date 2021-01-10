import 'dart:convert';
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
      String img, double price, int quantity, int id) {
    this.id = id;
    this.title = title;
    this.quantity = quantity;
    this.description = description;
    this.ingredients = ingredients;
    this.img = img;
    this.price = price;
  }

  Dish.fromJson(Map<String, dynamic> json) {
    List<Ingredient> ingredientsConverted = [];
    for (var item in json['ingredients'])
      ingredientsConverted.add(Ingredient.fromJson(item));

    id = json['id'];
    title = json['title'];
    quantity = json['quantity'];
    description = json['description'];
    ingredients = ingredientsConverted;
    img = json['img'];
    price = json['price'];
  }
  Map<String, dynamic> toJson() {
    List<dynamic> ingredientFormated = [];
    for (var item in ingredients) ingredientFormated.add(item.toJson());

    Map<String, dynamic> result = {
      'id': id,
      'title': title,
      'quantity': quantity,
      'description': description,
      'ingredients': ingredientFormated,
      'img': img,
      'price': price
    };
    return result;
  }

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

  void update() async {
    List<Dish> cart = await Dish.load();
    for (var item in cart) {
      if (item.id == this.id) {
        await item.delete();
        this.save();
        break;
      }
    }
  }

  void save() async {
    var actualList = await Dish.load();

    if (isAlreadyExist(actualList, id)) id = actualList.last.id + 1;

    actualList.add(this);
    actualList.map((e) => e.toJson()).toList();

    final pref = await SharedPreferences.getInstance();
    pref.setString('dish', jsonEncode(actualList));
  }

  static Future<List<Dish>> load() async {
    final pref = await SharedPreferences.getInstance();
    final loaded = pref.getString('dish');
    List<Dish> result = [];

    if (loaded == null) return result;

    var decoded = json.decode(loaded) as List;
    for (var item in decoded) result.add(Dish.fromJson(item));
    return result;
  }

  static double totalToPay(List<Dish> cart) {
    int i = 0;
    double toPay = 0.0;

    while (i != cart.length) toPay += cart[i].price * cart[i].quantity;
    return toPay;
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

  static void reset() async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('dish', null);
  }
}
