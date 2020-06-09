import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prankbros2/app/auth/forgotpassword/SendEmail.dart';
import 'package:prankbros2/customviews/CustomViews.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Keys.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  static const Key forgotPasswordKey = Key(Keys.forgotPasswordKey);
  TextEditingController _emailController;
  bool isLoading = false;

  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool _validation(BuildContext context) {
    if (_emailController.text == null || _emailController.text.isEmpty) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter your email.')));
      return false;
    }
    return true;
  }

  void _sendEmailPressed() {
    print('send email click');
    Navigator.pushReplacementNamed(context, Strings.SEND_EMAIL_ROUTE);
//    Navigator.push(
//        context, MaterialPageRoute(builder: (context) => SendEmail()));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      statusBarBrightness: Brightness.light,
    ));

    void _backPressed() {
      Navigator.pop(context);
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: _backPressed,
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
                        color: AppColors.black)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Dimens.TWENTY, left: Dimens.TWENTY),
            child: Text(
              AppLocalizations.of(context).translate(Strings.password_reset),
              style: TextStyle(
                  fontFamily: "Exo 2",
                  color: AppColors.black_text,
                  fontSize: Dimens.THIRTY),
            ),
          ),
          SizedBox(
            height: Dimens.TWENTY,
          ),
          Divider(
            color: AppColors.light_gray,
          ),
          SizedBox(
            height: Dimens.FORTY,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: Dimens.FIFTY),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).translate(Strings.email),
                    style: TextStyle(
                        letterSpacing: 1,
                        fontFamily: Strings.EXO_FONT,
                        fontSize: Dimens.THRTEEN,
                        color: AppColors.light_text),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.red,
                      hintText: Strings.enter_your_email,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintStyle: TextStyle(
                          fontFamily: Strings.EXO_FONT,
                          fontWeight: FontWeight.w600,
                          fontSize: Dimens.SIXTEEN,
                          color: AppColors.light_text),
                      labelStyle: TextStyle(
                          fontFamily: Strings.EXO_FONT,
                          fontWeight: FontWeight.w600,
                          fontSize: Dimens.SIXTEEN,
                          color: AppColors.black_text),
                    ),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  ),
                  Divider(
                    color: AppColors.light_gray,
                  ),
                ],
              )),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: _resetPasswordButton(),
            ),
          ),
          SizedBox(
            height: Dimens.FORTY,
          )
        ],
      ),
    );
  }

  Widget _resetPasswordButton() {
    return Builder(
      builder: (context) => CustomRaisedButton(
        key: forgotPasswordKey,
        text:
            AppLocalizations.of(context).translate(Strings.reset_your_password),
        backgroundColor: AppColors.pink_stroke,
        height: Dimens.SIXTY,
        width: MediaQuery.of(context).size.width - 100,
        borderRadius: Dimens.THIRTY,
        onPressed: _sendEmailPressed,
        isGradient: true,
        loading: isLoading,
        textStyle: TextStyle(
          fontSize: Dimens.FORTEEN,
          letterSpacing: 1.12,
          color: AppColors.white,
          fontWeight: FontWeight.w700,
          fontFamily: Strings.EXO_FONT,
        ),
      ),
    );
  }
}
