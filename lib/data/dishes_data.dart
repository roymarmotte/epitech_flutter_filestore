import 'package:epitech_flutter_filestore/items/dish.dart';
import 'package:epitech_flutter_filestore/items/ingredient.dart';

List<Dish> initialDish = [
  Dish(
      "Omelette au fromage",
      "Dish made from beaten eggs, fried with butter or oil in a frying pan.",
      [
        Ingredient("4 Eggs", true),
        Ingredient("Salt", true),
        Ingredient("Pepper", true),
        Ingredient("1 ounce Parmesan Cheese", true),
        Ingredient("2 tablespoons Butter", true),
        Ingredient("2 ounces gruyere chesse", true),
      ],
      "https://www.canalvie.com/polopoly_fs/1.8675792!/image/Omelette%20fromage.jpg_gen/derivatives/cvlandscape_499_281/Omelette%20fromage.jpg",
      8.00,
      1,
      0),
  Dish(
      "Welsh",
      "Le Welsh is basically cheese on toast, but with a few added extras - depending on where you are - like beer, mustard or ham.",
      [
        Ingredient("4 slices of bread", true),
        Ingredient("2 tablespoons (30g) of Dijon Mustard", true),
        Ingredient("1 tablespoon (15ml) Worcestershire sauce", true),
        Ingredient("3 cups (300g) Orange cheddar", true),
        Ingredient("1 3/4 cup (~400ml) Brown Ale", true),
      ],
      "https://img.cuisineaz.com/660x660/2019-08-08/i149772-welsh-au-thermomix.jpeg",
      9.20,
      2,
      1),
];
