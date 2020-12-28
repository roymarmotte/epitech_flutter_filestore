import 'package:flutter/material.dart';

class CartComponent extends StatelessWidget {
  const CartComponent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Image,
          Container(
            color: Colors.black,
          ),
          Text(
            "cart Component",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
