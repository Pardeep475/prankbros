import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
