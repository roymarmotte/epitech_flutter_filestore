import 'package:epitech_flutter_filestore/items/ingredient.dart';

class Dish {
  double price;
  int quantity;
  String img;
  List<Ingredient> ingredients;
  String title;
  String description;

  Dish(String title, String description, List<Ingredient> ingredient,
      String img, double price, int quantity) {
    this.title = title;
    this.description = description;
    this.img = img;
    this.price = price;
    this.ingredients = ingredients;
    this.quantity = quantity;
  }

  void changeIngredient(String ingredientToAdd, bool precense) {
    Ingredient newItem = Ingredient(ingredientToAdd, precense);
    int indexIngredient =
        ingredients.indexWhere((element) => element.title == ingredientToAdd);
    ingredients[indexIngredient] = newItem;
  }
}
