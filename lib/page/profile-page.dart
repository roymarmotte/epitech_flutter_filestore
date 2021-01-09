import 'dart:io';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
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
  User _user;
  Future<String> _imagePath;
  var _bottomNavIndex = 1;
  final iconList = <IconData>[
    Icons.home,
    Icons.account_circle_outlined,
    Icons.shopping_basket_outlined,
  ];
  final routeList = <String>["/", "/profile", "/cart"];

  void chooseImagePicker(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Take a picture"),
      onPressed: () {
        setState(() {
          _imagePath = getImageFromCamera(context);
        });
        Navigator.of(context).pop();
      },
    );
    Widget openSettingsButton = FlatButton(
      child: Text("Choose a picture already saved"),
      onPressed: () {
        setState(() {
          _imagePath = getImageFromGallery(context);
        });
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      actions: [
        openSettingsButton,
        cancelButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: new Center(
              child: Text(
            "Restaurant Delivery",
            textAlign: TextAlign.center,
          )),
        ),
        body: ValueListenableBuilder(
          valueListenable: editionCheck,
          builder: (context, value, widget) {
            return SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: EdgeInsets.only(bottom: bottom),
                child: FutureBuilder<User>(
                  future: User.load(),
                  builder:
                      (BuildContext context, AsyncSnapshot<User> snapshot) {
                    if (snapshot.hasData) {
                      _user = snapshot.data;
                      return Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    FutureBuilder<String>(
                                      future: _imagePath,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<String> snapshotImg) {
                                        if (snapshotImg.hasData) {
                                          _user.picturePath = snapshotImg.data;
                                          _user.save();
                                        }
                                        return (_user.picturePath == null
                                            ? InkWell(
                                                onTap: () {
                                                  chooseImagePicker(context);
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.25,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  decoration: new BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image:
                                                          new DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: Image.asset(
                                                                'images/basic_profile.png')
                                                            .image,
                                                      )),
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  chooseImagePicker(context);
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.25,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  decoration: new BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image:
                                                          new DecorationImage(
                                                        fit: BoxFit.contain,
                                                        image: Image.file(
                                                          File(_user
                                                              .picturePath),
                                                        ).image,
                                                      )),
                                                ),
                                              ));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.402,
                                width: MediaQuery.of(context).size.width,
                                child: ListView(
                                    padding: const EdgeInsets.all(8),
                                    children: [
                                      ProfileComponent(
                                          label: "First Name",
                                          fieldName: "firstname",
                                          user: _user),
                                      ProfileComponent(
                                          label: "Last Name",
                                          fieldName: "lastname",
                                          user: _user),
                                      ProfileComponent(
                                          label: "Street",
                                          fieldName: "street",
                                          user: _user),
                                      ProfileComponent(
                                          fieldName: "postalCode",
                                          label: "ZIP Code",
                                          user: _user),
                                      ProfileComponent(
                                          fieldName: "city",
                                          label: "City",
                                          user: _user),
                                      ProfileComponent(
                                          label: "Country",
                                          fieldName: "country",
                                          user: _user),
                                    ]),
                              ),
                              Text(
                                  "You can edit by clicking on informations/picture")
                            ],
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      print("error");
                      return Text("Aaaaand, it's a crash. Whoops :c");
                    } else {
                      return SizedBox(
                        child: CircularProgressIndicator(),
                        width: 60,
                        height: 60,
                      );
                    }
                  },
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: iconList,
          activeIndex: _bottomNavIndex,
          backgroundColor: Theme.of(context).primaryColor,
          gapLocation: GapLocation.none,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          leftCornerRadius: 0,
          rightCornerRadius: 0,
          onTap: (index) =>
              Navigator.pushReplacementNamed(context, routeList[index]),
        ));
  }
}
