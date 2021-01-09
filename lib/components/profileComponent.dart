import 'package:epitech_flutter_filestore/items/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

var editionCheck = ValueNotifier<int>(0);

class ProfileComponent extends StatefulWidget {
  final String label;
  final User user;
  final String fieldName;
  final String fillHint;

  ProfileComponent(
      {Key key,
      @required this.fieldName,
      @required this.user,
      @required this.label,
      @required this.fillHint})
      : super(key: key);

  @override
  ProfileComponentState createState() => ProfileComponentState(
      fieldName: fieldName, user: user, label: label, fillHint: fillHint);
}

class ProfileComponentState extends State<ProfileComponent> {
  ProfileComponentState(
      {@required fieldName,
      @required user,
      @required label,
      @required fillHint}) {
    this.fieldName = fieldName;
    this.user = user.toJson();
    this.label = label;
    this.fillHint = fillHint;
  }

  String label;
  String fieldName;
  Map<String, dynamic> user;
  bool isEditMode = false;
  int myTurn = 0;
  String fillHint;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: editionCheck,
        builder: (context, value, widget) {
          if (isEditMode && editionCheck.value == myTurn) {
            return Container(
              color: Colors.grey[300],
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.label,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    TextFormField(
                      autofillHints: [this.fillHint],
                      style: TextStyle(fontSize: 18),
                      initialValue: user[fieldName].toString(),
                      decoration: InputDecoration(isCollapsed: true),
                      autofocus: true,
                      onFieldSubmitted: (String value) {
                        setState(
                          () {
                            isEditMode = false;
                            user[fieldName] = value;
                            User.fromJson(user).save();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            isEditMode = false;
            return InkWell(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.label,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      user[fieldName].toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              onTap: () {
                editionCheck.value += 1;
                isEditMode = true;
                myTurn = editionCheck.value;
              },
            );
          }
        });
  }
}
