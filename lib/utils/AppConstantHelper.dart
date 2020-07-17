import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AppConstantHelper {
  BuildContext context;

  AppConstantHelper._internal();

  static final AppConstantHelper _singleton = AppConstantHelper._internal();

  factory AppConstantHelper() {
    return _singleton;
  }

  setContext(BuildContext context) {
    this.context = context;
  }


  Future<bool> requestPermissionForStorageandCamera(bool isCamera) async {
    if (!isCamera) {
      print("Pickerrd1");
      Map<Permission, PermissionStatus> storageStatuses = await [
        Permission.storage,
      ].request().then((value) {
        if (value == PermissionStatus.granted) {
          print("Pickerrd");
        }
      });

      if (storageStatuses == PermissionStatus.denied ||
          storageStatuses == PermissionStatus.denied ||
          storageStatuses == PermissionStatus.restricted) {
        showAlert(true, "Nedd permissions");
      }
    } else {
      Map<Permission, PermissionStatus> cameraStatus = await [
        Permission.camera,
      ].request();

      // ignore: unrelated_type_equality_checks
      if (cameraStatus == PermissionStatus.granted) {
        return true;
      }
      if (cameraStatus == PermissionStatus.denied ||
          cameraStatus == PermissionStatus.denied ||
          cameraStatus == PermissionStatus.restricted) {
        showAlert(true, "Nedd permissions");
      }
    }
  }

  File imageFile;

  Future<Null> pickImage({bool isCamera, Function(File) imagePicked}) async {
    imageFile = isCamera
        ? await ImagePicker.pickImage(
            source: ImageSource.camera,
          )
        : await ImagePicker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      print("imageFile>>${imageFile.path}");
    } else {
      showAlert(true, "Need Camera & Gellery Permission");
    }
  }



  void showAlert(bool val, String text) {
    print(context);
    var alert = AlertDialog(
      title: Text("Error"),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      )),
      content: Stack(
        children: <Widget>[
          Container(
            child: Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
          ),
//          Positioned(
//              top: 0,
//              child: Image.asset(
//                Images.ICON_APP_NIGERIA,
//                height: 50,
//                width: 50,
//              ))
        ],
      ),
      actions: [
        new FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "OK",
              style: TextStyle(color: Colors.blue),
            ))
      ],
    );

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }
}
