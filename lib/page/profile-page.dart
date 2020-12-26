import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:epitech_flutter_filestore/page/home-page.dart';
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
  final routeList = <String>[
    "/",
    "/profile",
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: new Center(
            child: Text(
          "Restaurant Delivery",
          textAlign: TextAlign.center,
        )),
      ),
      body: FutureBuilder<User>(
        future: User.load(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            _user = snapshot.data;
            return Column(
              children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.40,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey,
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
                                  ? Image.asset('images/basic_profile.png',
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      width: MediaQuery.of(context).size.width *
                                          0.25)
                                  : Image.file(
                                      File(_user.picturePath),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                    ));
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  alignment: Alignment.bottomCenter,
                                  child: IconButton(
                                      icon: Icon(Icons.add_a_photo),
                                      onPressed: () {
                                        setState(() {
                                          _imagePath =
                                              getImageFromCamera(context);
                                        });
                                      })),
                              Container(
                                  alignment: Alignment.bottomCenter,
                                  child: IconButton(
                                      icon: Icon(Icons.folder),
                                      onPressed: () {
                                        setState(() {
                                          _imagePath =
                                              getImageFromGallery(context);
                                        });
                                      })),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.402,
                      width: MediaQuery.of(context).size.width,
                      child:
                          ListView(padding: const EdgeInsets.all(8), children: [
                        ProfileComponent(
                            fieldName: "Firstname",
                            fieldValue: _user.firstname),
                        ProfileComponent(
                            fieldName: "Lastname", fieldValue: _user.lastname),
                        ProfileComponent(
                            fieldName: "Street", fieldValue: _user.street),
                        ProfileComponent(
                            fieldName: "Zip Code",
                            fieldValue: _user.postalCode.toString()),
                        ProfileComponent(
                            fieldName: "City", fieldValue: _user.city),
                        ProfileComponent(
                            fieldName: "Country", fieldValue: _user.country),
                      ]),
                    )
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
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _bottomNavIndex,
        backgroundColor: HexColor('#4285F4'),
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        onTap: (index) =>           Navigator.pushReplacementNamed(context, routeList[index]),
      )
    );
  }
}
