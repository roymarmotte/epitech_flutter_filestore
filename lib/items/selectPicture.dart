import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

showAlertDialog(BuildContext context, String _title, String _description) {
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget openSettingsButton = FlatButton(
    child: Text("Open permissions"),
    onPressed: openAppSettings,
  );

  AlertDialog alert = AlertDialog(
    title: Text(_title),
    content: Text(_description),
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

Future<String> getImageFromCamera(BuildContext context) async {
  try {
    PermissionStatus status = await Permission.camera.status;
    if (status.isGranted || status.isUndetermined) {
      PickedFile pickedFile =
          await ImagePicker().getImage(source: ImageSource.camera);
      return pickedFile.path;
    } else
      showAlertDialog(context, "Access denied",
          "You need to give access to your camera in order to take a picture.");
    return null;
  } catch (error) {
    print("An error occured. Unable to pick an image from Camera: {$error}");
    return null;
  }
}

Future<String> getImageFromGallery(BuildContext context) async {
  try {
    PermissionStatus status = await Permission.storage.status;
    if (status.isGranted) {
      PickedFile pickedFile =
          await ImagePicker().getImage(source: ImageSource.gallery);
      return pickedFile.path;
    } else
      showAlertDialog(context, "Access denied",
          "You need to give access to your storage in order to pick a picture.");
    return null;
  } catch (error) {
    print("An error occured. Unable to pick an image from Gallery: {$error}");
    return null;
  }
}
