import 'dart:convert';
import 'package:epitech_flutter_filestore/items/dish.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  String firstname;
  String lastname;
  String street;
  String postalCode;
  String city;
  String country;
  String picturePath;
  List<Dish> favorites;
  List<Dish> cart;

  User(this.firstname, this.lastname, this.street, this.postalCode, this.city,
      this.country, this.picturePath, this.favorites, this.cart);

  User.fromJson(Map<String, dynamic> json) {
    List<Dish> favoritesConverted = [];
    for (var item in json['favorites'])
      favoritesConverted.add(Dish.fromJson(item));

    List<Dish> cartConverted = [];
    for (var item in json['cart']) cartConverted.add(Dish.fromJson(item));

    firstname = json['firstname'];
    lastname = json['lastname'];
    street = json['street'];
    postalCode = json['postalCode'];
    city = json['city'];
    country = json['country'];
    picturePath = json['picturePath'];
    favorites = favoritesConverted;
    cart = cartConverted;
  }
  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
        'street': street,
        'postalCode': postalCode,
        'city': city,
        'country': country,
        'picturePath': picturePath,
        'favorites': favorites,
        'cart': cart
      };

  bool isAlreadyFavs(int id) {
    for (var item in favorites) if (item.id == id) return true;
    return false;
  }

  void addToCart(Dish toAdd) {
    for (var item in cart) {
        if (item.id == toAdd.id) {
            item.quantity = item.quantity + toAdd.quantity;
            print("Plat trouvé");
            return;
        }
    }
    cart.add(toAdd);
  }

  void cleanCart() {
    cart.clear();
  }

  Dish saveFavs(Dish toAdd) {
    if (isAlreadyFavs(toAdd.id)) toAdd.id = favorites.last.id + 1;
    favorites.add(toAdd);
    return toAdd;
  }

  void updateFavs(Dish toUpdate) {
    for (var item in favorites) {
      if (item.id == toUpdate.id) {
        item = toUpdate;
        break;
      }
    }
  }

  void deleteFavs(Dish toDelete) {
    for (var item in favorites) {
      if (item.id == toDelete.id) {
        favorites.remove(item);
        break;
      }
    }
  }

  void save() async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('user', jsonEncode(this.toJson()));
  }

  static void reset() async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('user', null);
  }

  static Future<User> load() async {
    final pref = await SharedPreferences.getInstance();
    final loaded = pref.getString('user');
    if (loaded == null)
      return User("James", "Cameron", "1 Boulevard du Général", "13086",
          "Paris", "France", null, [], []);
    return User.fromJson(json.decode(loaded));
  }
}
