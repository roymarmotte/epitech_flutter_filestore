import 'package:epitech_flutter_filestore/items/ingredient.dart';

class Dish {
  double price;
  String img;
  List<Ingredient> ingredients;
  String title;
  String description;
  int quantity;

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
  //A modifier (c'est juste pour les tests d'Hicham)
  static Future<Dish> load() async
  {
      return await Dish(
      "Titre",
      "Description",
      [Ingredient("Sel", true), Ingredient("Poivre", true)],
      "images/fromage.jpg",
      10,
      1); 
  }
}
