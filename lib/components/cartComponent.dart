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
          children: [
            Expanded(
              //padding: EdgeInsets.all(5.0),
              flex: 1,
              child: FittedBox(
                  child: Image(
                    image: NetworkImage(value.img),
                  ),
                  fit: BoxFit.fill),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text(
                    value.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    (value.price * value.quantity).toStringAsFixed(2) +
                        " euros",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
            Column(
              children: [
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
                IconButton(
                  icon: Icon(Icons.restore_from_trash),
                  onPressed: () {
                    setState(() {
                      callback(value, false);
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
