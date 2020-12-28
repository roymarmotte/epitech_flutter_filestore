import 'package:epitech_flutter_filestore/items/dish.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../page/dishes-page.dart';

class DishComponent extends StatelessWidget {
  DishComponent(this.dish);
  final Dish dish;

  @override
  Widget build(BuildContext context) {

    return Card(
          child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(this.dish.img), fit: BoxFit.fill),
          ),
        ),
        title: Text(this.dish.title),
        subtitle: Text(this.dish.description),
        isThreeLine: true,
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => DishesPage(dish)));
        });
  }
}
