import 'package:flutter/cupertino.dart';
import 'package:prankbros2/app/auth/forgotpassword/ForgotPassword.dart';
import 'package:prankbros2/app/auth/intro/Intro.dart';
import 'package:prankbros2/app/auth/login/Login.dart';

class Routes{

  var routes = <String, WidgetBuilder>{
    "/Login": (BuildContext context) => new Login(),
    "/Intro": (BuildContext context) => new Intro(),
    "/ForgotPassword": (BuildContext context) => new ForgotPassword(),
  };

}


