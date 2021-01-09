import 'dart:io';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:epitech_flutter_filestore/page/favorites-page.dart';
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

  chooseImagePicker(BuildContext context) {
    Widget fromCameraButton = FlatButton(
      child: Text("Take a picture with your camera"),
      onPressed: () {
        setState(() {
          _imagePath = getImageFromCamera(context);
        });
        Navigator.of(context).pop();
      },
    );
    Widget fromGalleryButton = FlatButton(
      child: Text("Choose a picture from your gallery"),
      onPressed: () {
        setState(() {
          _imagePath = getImageFromGallery(context);
        });
        Navigator.of(context).pop();
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      actions: [fromGalleryButton, fromCameraButton, cancelButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

/* OutlineButton(
                                onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => FavoritesPage())),
                                child: Text("Click here to see the favorites"),
                              ) */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ValueListenableBuilder(
          valueListenable: editionCheck,
          builder: (context, value, widget) {
            return FutureBuilder<User>(
              future: User.load(),
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                if (snapshot.hasData) {
                  _user = snapshot.data;
                  return displayProfilPage(context);
                } else if (snapshot.hasError) {
                  print("Profil page snapshot error:\n${snapshot.error}");
                  return Text(
                      "An error occured. Unable to load your profil.\nTry restarting the application.\n\n${snapshot.error}");
                } else {
                  return SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  );
                }
              },
            );
          },
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: iconList,
          activeIndex: _bottomNavIndex,
          backgroundColor: Theme.of(context).primaryColor,
          activeColor: Colors.white,
          gapLocation: GapLocation.none,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          leftCornerRadius: 0,
          rightCornerRadius: 0,
          onTap: (index) =>
              Navigator.pushReplacementNamed(context, routeList[index]),
        ));
  }

  Column displayProfilPage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: FutureBuilder<String>(
            future: _imagePath,
            builder: (BuildContext context, AsyncSnapshot<String> snapshotImg) {
              if (snapshotImg.hasData) {
                _user.picturePath = snapshotImg.data;
                _user.save();
              }
              return Center(
                child: InkWell(
                  onTap: () {
                    chooseImagePicker(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 100,
                    child: _user.picturePath == null
                        ? Image.asset('images/basic_profile.png')
                        : Image.file(File(_user.picturePath)),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          flex: 7,
          child: ListView(children: [
            ProfileComponent(
                label: "First Name",
                fieldName: "firstname",
                user: _user,
                fillHint: AutofillHints.givenName),
            ProfileComponent(
                label: "Last Name",
                fieldName: "lastname",
                user: _user,
                fillHint: AutofillHints.familyName),
            ProfileComponent(
                label: "Street",
                fieldName: "street",
                user: _user,
                fillHint: AutofillHints.streetAddressLevel1),
            ProfileComponent(
                fieldName: "postalCode",
                label: "ZIP Code",
                user: _user,
                fillHint: AutofillHints.postalCode),
            ProfileComponent(
                fieldName: "city",
                label: "City",
                user: _user,
                fillHint: AutofillHints.addressCity),
            ProfileComponent(
                label: "Country",
                fieldName: "country",
                user: _user,
                fillHint: AutofillHints.countryName),
          ]),
        ),
      ],
    );
  }
}
