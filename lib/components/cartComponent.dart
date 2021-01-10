import 'package:epitech_flutter_filestore/items/user.dart';
import 'package:flutter/material.dart';
import 'package:epitech_flutter_filestore/items/dish.dart';
import 'package:flutter/foundation.dart';

class CartComponent extends StatefulWidget {
  final Dish value;
  final Function callback;
  CartComponent({Key key, @required this.value, @required this.callback})
      : super(key: key);

  @override
  _CartComponentState createState() =>
      _CartComponentState(value: value, callback: callback);
}

class _CartComponentState extends State<CartComponent> {
  _CartComponentState({@required this.value, @required this.callback});

  Dish value;
  Function callback;
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
                Text(
                  (value.price * value.quantity).toStringAsFixed(2) + " euros",
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.restore_from_trash),
              onPressed: () {
                setState(() {
                  callback(value, false);
                });
              },
            ),
            Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (value.quantity < 1) value.quantity = 1;
                        value.quantity -= 1;
                        callback(value, true);
                      });
                    },
                    child: Text(
                      "-",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  SizedBox(width: 23),
                  Text(
                    value.quantity.toString(),
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: 23),
                  InkWell(
                    onTap: () {
                      setState(() {
                        value.quantity += 1;
                        callback(value, true);
                      });
                    },
                    child: Text(
                      "+",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
