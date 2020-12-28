import 'package:epitech_flutter_filestore/items/ingredient.dart';

class Dish {
  String title;
  String description;
  List<Ingredient> ingredients;
  String img;
  double price;

  Dish(String title, String description, List<Ingredient> ingredients,
      String img, double price) {
    this.title = title;
    this.description = description;
    this.ingredients = ingredients;
    this.img = img;
    this.price = price;
  }

  void changeIngredient(String ingredientToAdd, bool precense) {
    Ingredient newItem = Ingredient(ingredientToAdd, precense);
    int indexIngredient =
        ingredients.indexWhere((element) => element.title == ingredientToAdd);
    ingredients[indexIngredient] = newItem;
  }
}
