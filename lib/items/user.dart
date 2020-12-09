import 'dart:convert';

import 'package:epitech_flutter_filestore/items/dish.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  String firstname;
  String lastname;
  String street;
  int postalCode;
  String city;
  String country;
  Image picture;
  List<Dish> favorites;

  User(this.firstname, this.lastname, this.street, this.postalCode, this.city,
      this.country, this.picture, this.favorites);

  User.fromJson(Map<String, dynamic> json)
      : firstname = json['firstname'],
        lastname = json['lastname'],
        street = json['street'],
        postalCode = json['postalCode'],
        city = json['city'],
        country = json['country'],
        picture = json['picture'],
        favorites = json['favorites'];
  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
        'street': street,
        'postalCode': postalCode,
        'city': city,
        'country': country,
        'picture': picture,
        'favorites': favorites,
      };

  void save() async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('user', jsonEncode(this.toJson()));
  }

  static Future<User> load() async {
    final pref = await SharedPreferences.getInstance();
    final loaded = pref.getString('user');
    if (loaded == null) return null;
    return User.fromJson(json.decode(loaded));
  }
}
