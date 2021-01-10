import 'package:epitech_flutter_filestore/items/user.dart';
import 'package:flutter/material.dart';
import 'package:epitech_flutter_filestore/items/dish.dart';
import 'package:flutter/foundation.dart';

class CartComponent extends StatefulWidget {
  final Dish value;
  CartComponent({Key key, @required this.value}) : super(key: key);

  @override
  _CartComponentState createState() => _CartComponentState(value: value);
}

class _CartComponentState extends State<CartComponent> {
  _CartComponentState({@required value}) {
    this.value = value;
  }

  Dish value;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: User.load(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        Text("Quantity : " + value.quantity.toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal)),
                        Text(
                          (value.price * value.quantity).toStringAsFixed(2) +
                              " euros",
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.restore_from_trash),
                      onPressed: () {
                        setState(() {
                          int i = 0;

                          while (i < snapshot.data.cart.length) {
                            if (value.id == snapshot.data.cart[i].id)
                              snapshot.data.cart.removeAt(i);
                            i++;
                          }
                          snapshot.data.save();
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
                                int i = 0;
                                if (value.quantity < 1) value.quantity = 1;
                                value.quantity -= 1;
                                while (i < snapshot.data.cart.length) {
                                  if (value.id == snapshot.data.cart[i].id) {
                                    snapshot.data.cart[i].quantity =
                                        value.quantity;
                                    i++;
                                  }
                                }
                                snapshot.data.save();
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
                                int i = 0;
                                value.quantity += 1;
                                while (i < snapshot.data.cart.length) {
                                  if (value.id == snapshot.data.cart[i].id) {
                                    snapshot.data.cart[i].quantity =
                                        value.quantity;
                                    i++;
                                  }
                                }
                                snapshot.data.save();
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
          } else {
            return Column();
          }
        });
  }
}
