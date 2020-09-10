import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prankbros2/app/auth/forgotpassword/ForgotPasswordBloc.dart';
import 'package:prankbros2/commonwidgets/ease_in_widget.dart';
import 'package:prankbros2/customviews/CommonProgressIndicator.dart';
import 'package:prankbros2/customviews/CustomViews.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Keys.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Utils.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  static const Key forgotPasswordKey = Key(Keys.forgotPasswordKey);
  TextEditingController _emailController;
  bool isLoading = false;
  ForgotPasswordBloc _forgotPasswordBloc;

  void initState() {
    super.initState();
    _forgotPasswordBloc = new ForgotPasswordBloc();
    _emailController = TextEditingController();
  }

  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool _validation(BuildContext context) {
    if (Utils.checkNullOrEmpty(_emailController.text)) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter your email.')));
      return false;
    }
    return true;
  }

  void _sendEmailPressed(BuildContext context) {
    print('send email click');
    Utils.checkConnectivity().then((value) {
      if (value) {
        if (_validation(context)) {
          _forgotPasswordBloc.doForgotPassword(_emailController.text, context);
        }
      } else {
        Utils.showSnackBar(
            Strings.please_check_your_internet_connection, context);
      }
    });
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
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
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
                      child: EaseInWidget(
                    onTap: _backPressed,
                    borderRadius: Dimens.THIRTY,
                    child: Image.asset(Images.ArrowBackWhite,
                        height: Dimens.fifteen,
                        width: Dimens.twenty,
                        color: AppColors.black),
                  )),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: Dimens.TWENTY, left: Dimens.TWENTY),
                child: Text(
                  AppLocalizations.of(context)
                      .translate(Strings.password_reset),
                  style: TextStyle(
                      fontFamily: Strings.EXO_FONT,
                      color: AppColors.black_text,
                      fontWeight: FontWeight.w700,
                      fontSize: Dimens.thirty),
                ),
              ),
              SizedBox(
                height: Dimens.twenty,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.twenty),
                child: Divider(
                  color: AppColors.divider_color,
                ),
              ),
              SizedBox(
                height: Dimens.forty,
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
                            fontSize: Dimens.fifteen,
                            fontWeight: FontWeight.w600,
                            color: AppColors.light_text),
                      ),
                      SizedBox(
                        height: Dimens.six,
                      ),
                      TextField(
                        maxLines: 1,
                        minLines: 1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0.0),
                          isDense: true,
                          hintText: AppLocalizations.of(context)
                              .translate(Strings.enter_your_email),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintStyle: TextStyle(
                              fontFamily: Strings.EXO_FONT,
                              fontWeight: FontWeight.w600,
                              fontSize: Dimens.sixteen,
                              color: AppColors.light_text),
                        ),
                        style: TextStyle(
                            fontFamily: Strings.EXO_FONT,
                            fontWeight: FontWeight.w600,
                            fontSize: Dimens.sixteen,
                            color: AppColors.black_text),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => FocusScope.of(context).unfocus(),
                      ),
                      SizedBox(
                        height: Dimens.four,
                      ),
                      Divider(
                        color: AppColors.divider_color,
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
                height: Dimens.forty,
              )
            ],
          ),
          StreamBuilder<bool>(
            stream: _forgotPasswordBloc.progressStream,
            builder: (context, snapshot) {
              return Center(
                  child: CommonProgressIndicator(
                      snapshot.hasData ? snapshot.data : false));
            },
          ),
        ],
      ),
    );
  }

  Widget _resetPasswordButton() {
    return Builder(
      builder: (context) => CustomRaisedButton(
        key: forgotPasswordKey,
        text: AppLocalizations.of(context)
            .translate(Strings.reset_your_password)
            .toUpperCase(),
        backgroundColor: AppColors.pink_stroke,
        height: Dimens.fiftyThree,
        width: MediaQuery.of(context).size.width - Dimens.eighty,
        borderRadius: Dimens.THIRTY,
        onPressed: () {
          _sendEmailPressed(context);
        },
        isGradient: true,
        loading: isLoading,
        textStyle: TextStyle(
          fontSize: Dimens.forteen,
          letterSpacing: 1.12,
          color: AppColors.white,
          fontWeight: FontWeight.w700,
          fontFamily: Strings.EXO_FONT,
        ),
      ),
    );
  }
}
