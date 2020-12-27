import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

var editionCheck = ValueNotifier<int>(0);

class ProfileComponent extends StatefulWidget {
  final String fieldName;
  final String fieldValue;

  ProfileComponent(
      {Key key, @required this.fieldName, @required this.fieldValue})
      : super(key: key);

  @override
  ProfileComponentState createState() =>
      ProfileComponentState(fieldName: fieldName, fieldValue: fieldValue);
}

class ProfileComponentState extends State<ProfileComponent> {
  ProfileComponentState({@required this.fieldName, @required this.fieldValue});

  final String fieldName;
  String fieldValue;
  bool isEditMode = false;
  int myTurn = 0;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: editionCheck,
        builder: (context, value, widget) {
          /*print("Rebuild pour " +
              fieldName +
              "\n\tEdit mode: " +
              isEditMode.toString() +
              "\n\t Turn: " +
              myTurn.toString() +
              "\n\tGlobal: " +
              editionCheck.value.toString());*/

          if (isEditMode && editionCheck.value == myTurn) {
            return Container(
              height: 50,
              width: 50,
              child: ListTile(
                title: Text(this.fieldName),
                subtitle: TextFormField(
                  initialValue: fieldValue,
                  decoration: InputDecoration(isCollapsed: true),
                  autofocus: true,
                  onFieldSubmitted: (String value) {
                    setState(() {
                      isEditMode = false;
                      fieldValue = value;
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
                  title: Text(this.fieldName),
                  subtitle: Text(this.fieldValue),
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
