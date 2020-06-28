import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/auth/login/Login.dart';
import 'package:prankbros2/customviews/CustomViews.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Keys.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';

class SendEmail extends StatelessWidget {
  // dynamic responsive
  static const Key sendEmailKey = Key(Keys.sendEmailKey);

  void _backPress(BuildContext context) {
    print('sldflkf');
//    Navigator.pushAndRemoveUntil(
//        context,
//        MaterialPageRoute(builder: (context) => Login()),
//        ModalRoute.withName('/Login'));

    Navigator.pushNamedAndRemoveUntil(
        context, Strings.LOGIN_ROUTE, (route) => false);
  }

  Future<bool> _onBackPressed(BuildContext context) {
    print('sldflkf');
//    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    Navigator.pushNamedAndRemoveUntil(
        context, Strings.LOGIN_ROUTE, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _onBackPressed(context);
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
                          height: Dimens.fifteen,
                          width: Dimens.twenty,
                          color: Colors.black)),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      Images.SendImage,
                      height: 65,
                      width: 160,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: Dimens.FIFTY,
                    ),
                    Text(
                      AppLocalizations.of(context).translate(Strings.send_email),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: Strings.EXO_FONT,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black_text,
                        fontSize: Dimens.SEVENTEEN,
                      ),
                    )
                  ],
                ),
              ),
            ),
            _sendEmailButton(),
            SizedBox(
              height: Dimens.forty,
            )
          ],
        ),
      ),
    );
  }

  Widget _sendEmailButton() {
    return Builder(
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimens.forty),
        child: CustomRaisedButton(
          key: sendEmailKey,
          text: AppLocalizations.of(context)
              .translate(Strings.zur_anmeldung)
              .toUpperCase(),
          backgroundColor: AppColors.pink_stroke,
          height: Dimens.fiftyThree,
          width: MediaQuery.of(context).size.width,
          borderRadius: Dimens.THIRTY,
          onPressed: () {
            _backPress(context);
          },
          isGradient: true,
          loading: false,
          textStyle: TextStyle(
            fontSize: Dimens.forteen,
            letterSpacing: 1.12,
            color: AppColors.white,
            fontWeight: FontWeight.w700,
            fontFamily: Strings.EXO_FONT,
          ),
        ),
      ),
    );
  }
}
