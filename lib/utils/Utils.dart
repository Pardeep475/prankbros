import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:toast/toast.dart';

class Utils {
  static Future<bool> checkConnectivity() async {
    bool _isConnected = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        _isConnected = true;
      } else {
        _isConnected = false;
      }
    } on SocketException catch (_) {
      print('not connected');
      _isConnected = false;
    }

    return _isConnected;
  }

  static showToast(String message, BuildContext context) {
    Toast.show(
      message,
      context,
      duration: 2,
      gravity: Toast.CENTER,
      textColor: AppColors.white,
    );
  }

  static showSnackBar(String message, BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  static bool checkNullOrEmpty(String value) {
    if (value == null || value.isEmpty) return true;
    return false;
  }

  static showAlertDialog(BuildContext context, String message) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0.0,
        insetAnimationCurve: Curves.easeInOutBack,
        backgroundColor: Colors.transparent,
        child: Center(
          child: Stack(
            children: <Widget>[
              //...bottom card part,
              Container(
                padding:
                    EdgeInsets.only(left: 60, right: 60, top: 50, bottom: 20),
                margin: EdgeInsets.only(top: 30, bottom: 100),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: const Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // To make the card compact
                  children: <Widget>[
                    Text(
                      message,
                      style: TextStyle(
                        color: AppColors.black_text,
                        fontWeight: FontWeight.w500,
                        fontFamily: Strings.EXO_FONT,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
//              Positioned(
//                top: 0,
//                left: 0,
//                right: 0,
//                child: Image.asset(
//                  Images.ICON_APP_NIGERIA,
//                  height: 50,
//                  width: 50,
//                ),
//              ),
              Positioned(
                top: 24,
                right: 0,
                child: IconButton(
                  splashColor: Colors.black.withOpacity(0.5),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.clear,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
