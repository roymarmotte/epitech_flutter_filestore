import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:epitech_flutter_filestore/items/user.dart';
import 'package:flutter/material.dart';
import 'package:epitech_flutter_filestore/items/selectPicture.dart';
import 'package:epitech_flutter_filestore/components/profileComponent.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User _user = User("James", "Cameron", "1 Boulevard du Général", 13086,
      "Paris", "France", null, null);
  Future<String> _imagePath = null;
  final _errorSnapMessage = SnackBar(content: Text("Picture Error"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Center(
            child: Text(
          "Profile Page",
          textAlign: TextAlign.center,
        )),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //TODO : call router pushback();
            print("go back ! ");
          },
        ),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  ),
                  FutureBuilder<String>(
                    future: _imagePath,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        _user.picturePath = snapshot.data;
                        _user.save();
                      } else if (snapshot.hasError) {
                        Scaffold.of(context).showSnackBar(_errorSnapMessage);
                      }
                      return (_user.picturePath == null
                          ? Image.asset('images/basic_profile.png',
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.width * 0.25)
                          : Image.file(File(_user.picturePath)));
                    },
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                      child: IconButton(
                          icon: Icon(Icons.add_a_photo),
                          onPressed: () {
                            setState(() {
                              _imagePath = getImageFromGallery(context);
                            });
                          })),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.80,
                width: MediaQuery.of(context).size.height * 0.90,
                child: ListView(padding: const EdgeInsets.all(8), children: [
                  ProfileComponent(
                      fieldName: "Firstname", fieldValue: _user.firstname),
                  ProfileComponent(
                      fieldName: "Lastname", fieldValue: _user.lastname),
                  ProfileComponent(
                      fieldName: "Street", fieldValue: _user.street),
                  ProfileComponent(
                      fieldName: "Zip Code",
                      fieldValue: _user.postalCode.toString()),
                  ProfileComponent(fieldName: "City", fieldValue: _user.city),
                  ProfileComponent(
                      fieldName: "Country", fieldValue: _user.country),
                ]),
              )
            ],
          )
        ],
      ),
    );
  }
}
