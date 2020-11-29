import 'package:epitech_flutter_filestore/items/ingredient.dart';

class Dish {
  double price;
  String img;
  List<Ingredient> ingredients;
  String title;
  String description;

  Dish(String title, String description, List<Ingredient> ingredient,
      String img, double price) {
    this.title = title;
    this.description = description;
    this.img = img;
    this.price = price;
    this.ingredients = ingredients;
  }

  void changeIngredient(String ingredientToAdd, bool precense) {
    Ingredient newItem = Ingredient(ingredientToAdd, precense);
    int indexIngredient =
        ingredients.indexWhere((element) => element.title == ingredientToAdd);
    ingredients[indexIngredient] = newItem;
  }
}
