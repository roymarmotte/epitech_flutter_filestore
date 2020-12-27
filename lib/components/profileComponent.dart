import 'package:epitech_flutter_filestore/items/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

var editionCheck = ValueNotifier<int>(0);

class ProfileComponent extends StatefulWidget {
  final String label;
  final User user;
  final String fieldName;

  ProfileComponent(
      {Key key,
      @required this.fieldName,
      @required this.user,
      @required this.label})
      : super(key: key);

  @override
  ProfileComponentState createState() =>
      ProfileComponentState(fieldName: fieldName, user: user, label: label);
}

class ProfileComponentState extends State<ProfileComponent> {
  ProfileComponentState(
      {@required fieldName, @required user, @required label}) {
    this.fieldName = fieldName;
    this.user = user.toJson();
    this.label = label;
  }

  String label;
  String fieldName;
  Map<String, dynamic> user;
  bool isEditMode = false;
  int myTurn = 0;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: editionCheck,
        builder: (context, value, widget) {

          if (isEditMode && editionCheck.value == myTurn) {
            return Container(
              height: 50,
              width: 50,
              child: ListTile(
                title: Text(this.label),
                subtitle: TextFormField(
                  initialValue: user[fieldName].toString(),
                  decoration: InputDecoration(isCollapsed: true),
                  autofocus: true,
                  onFieldSubmitted: (String value) {
                    setState(() {
                      isEditMode = false;
                      user[fieldName] = value;
                      User.fromJson(user).save();
                    });
                  },
                ),
              ),
            );
          } else {
            isEditMode = false;
            return InkWell(
              child: Container(
                height: 50,
                width: 50,
                child: ListTile(
                  title: Text(this.label),
                  subtitle: Text(user[fieldName].toString()),
                ),
              ),
              onTap: () {
                editionCheck.value += 1;
                isEditMode = true;
                myTurn = editionCheck.value;
                //isFocus
              },
            );
          }
        });
  }
}
