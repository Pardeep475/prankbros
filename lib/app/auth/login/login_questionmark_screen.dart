import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';

class LoginQuestionMarkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: new DecorationImage(
          image: new AssetImage("assets/images/1.png"),
          fit: BoxFit.fill,
        )),
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            SafeArea(
                child: Align(
              child: Container(
                padding: EdgeInsets.all(20),
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    Images.ICON_CROSS,
                    color: Colors.white,
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
              alignment: Alignment.centerRight,
            )),
            SizedBox(
              height: 120,
            ),
            Text(
              'Strong by Prankbros !',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: Dimens.LOGIN_TWENTY_SEVEN2,
                  fontStyle: FontStyle.normal,
                  fontFamily: Strings.EXO_FONT,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white),
            ),
            SizedBox(
              height: 47,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      style: TextStyle(
                          fontSize: Dimens.LOGIN_FORTEEN,
                          fontStyle: FontStyle.normal,
                          fontFamily: Strings.EXO_FONT,
                          fontWeight: FontWeight.normal,
                          color: AppColors.white.withOpacity(0.6)),
                      text: Strings.login_question_mark_text1,
                    ),
                    TextSpan(
                      style: TextStyle(
                          fontSize: Dimens.LOGIN_FORTEEN,
                          fontStyle: FontStyle.normal,
                          fontFamily: Strings.EXO_FONT,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blue),
                      text: Strings.login_question_mark_text2,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          final url =
                              'https://${Strings.login_question_mark_text1}\n';
                          /*if (await canLaunch(url)) {
                    await launch(
                      url,
                      forceSafariVC: false,
                    );
                  }*/
                        },
                    ),
                    TextSpan(
                      style: TextStyle(
                          fontSize: Dimens.LOGIN_FORTEEN,
                          fontStyle: FontStyle.normal,
                          fontFamily: Strings.EXO_FONT,
                          fontWeight: FontWeight.normal,
                          color: AppColors.white.withOpacity(0.6)),
                      text: Strings.login_question_mark_text3,
                    ),
                    TextSpan(
                      style: TextStyle(
                          fontSize: Dimens.LOGIN_TWENTY_SEVEN,
                          fontStyle: FontStyle.normal,
                          fontFamily: Strings.EXO_FONT,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blue),
                      text: Strings.login_question_mark_text4,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
