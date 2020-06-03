import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/auth/login/Login.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';

class SendEmail extends StatelessWidget {
  // dynamic responsive

  void _backPress(BuildContext context) {
    print('sldflkf');
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()),ModalRoute.withName('/Login'));
  }

  Future<bool> _onBackPressed(BuildContext context) {
    print('sldflkf');
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _onBackPressed(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _backPress(context);
              },
              child: Container(
                width: Dimens.FORTY_FIVE,
                height: Dimens.FORTY_FIVE,
                margin: EdgeInsets.only(top: Dimens.FIFTY, left: Dimens.TWENTY),
                child: Container(
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    color: AppColors.light_gray,
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimens.THIRTY)),
                  ),
                  child: Center(
                      child: Image.asset(Images.ArrowBackWhite,
                          color: Colors.black)),
                ),
              ),
            ),
            Center(
              heightFactor: 4,
              child: Column(
                children: <Widget>[
                  Image.asset(Images.SendImage),
                  SizedBox(
                    height: Dimens.FIFTY,
                  ),
                  Text(
                    AppLocalizations.of(context).translate(Strings.send_email),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: Strings.EXO_FONT,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_text,
                      fontSize: Dimens.SEVENTEEN,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: GestureDetector(
                  onTap: (){
                    _backPress(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: Dimens.FIFTY,
                        right: Dimens.FIFTY,
                        bottom: Dimens.FORTY),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.dark_gray,
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.THIRTY)),
                      gradient: LinearGradient(
                        colors: [AppColors.pink, AppColors.blue],
                        begin: Alignment.bottomLeft,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: Dimens.SEVENTEEN),
                      child: Text(
                        AppLocalizations.of(context)
                            .translate(Strings.zur_anmeldung)
                            .toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: Dimens.SIXTEEN,
                          color: AppColors.white,
                          fontFamily: Strings.EXO_FONT,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
