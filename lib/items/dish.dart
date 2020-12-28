import 'package:epitech_flutter_filestore/items/ingredient.dart';

class Dish {
  String title;
  String description;
  List<Ingredient> ingredients;
  String img;
  double price;
  int quantity;

  Dish(String title, String description, List<Ingredient> ingredients,
      String img, double price, int quantity) {
    this.title = title;
    this.quantity = quantity;
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

  //A modifier (c'est juste pour les tests d'Hicham)
  static Future<Dish> load() async {
    return Dish(
        "Titre",
        "Description",
        [Ingredient("Sel", true), Ingredient("Poivre", true)],
        "images/fromage.jpg",
        10,
        1);
  }
}
