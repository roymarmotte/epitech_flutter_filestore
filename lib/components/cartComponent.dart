import 'package:flutter/material.dart';
import 'package:epitech_flutter_filestore/items/dish.dart';

class CartComponent extends StatelessWidget {
  final Dish value;
  const CartComponent({Key key, @required this.value}) : super(key: key);

  final double totalToPay = 0;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              //padding: EdgeInsets.all(5.0),
              height: MediaQuery.of(context).size.height * 0.10,
              width: MediaQuery.of(context).size.width * 0.20,
              child: FittedBox(
                  child: Image(
                    image: NetworkImage(value.img),
                  ),
                  fit: BoxFit.fill),
            ),
            Column(
              children: [
                Text(
                  value.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 5),
                Text("Quantity : " + value.quantity.toString(),
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                Text(
                  (value.price * value.quantity).toString() + " euros",
                  style: TextStyle(color: Colors.green),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
