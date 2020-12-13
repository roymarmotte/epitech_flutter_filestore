import 'package:epitech_flutter_filestore/items/dish.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// ignore: camel_case_types
class ProfileComponent extends StatelessWidget {
  const ProfileComponent(
      {Key key, @required this.fieldName, @required this.fieldValue})
      : super(key: key);

  final String fieldName;
  final String fieldValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      child: ListTile(
        title: Text(fieldName),
        subtitle: Text(fieldValue),
      ),
    );
  }
}
