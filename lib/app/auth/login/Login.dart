import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prankbros2/app/auth/login/LoginBloc.dart';
import 'package:prankbros2/customviews/CommonProgressIndicator.dart';
import 'package:prankbros2/customviews/CustomViews.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Keys.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Utils.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static const Key loginButtonKey = Key(Keys.loginButtonKey);
  TextEditingController _emailController;
  TextEditingController _passwordController;
  bool isLoading = false;
  LoginBloc _loginBloc;

  void initState() {
    super.initState();
    _loginBloc = new LoginBloc();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validation(BuildContext context) {
    if (Utils.checkNullOrEmpty(_emailController.text)) {
      Utils.showSnackBar(Strings.please_enter_your_email, context);
      return false;
    } else if (Utils.checkNullOrEmpty(_passwordController.text)) {
      Utils.showSnackBar(Strings.please_enter_your_password, context);
      return false;
    }
    return true;
  }

  _loginButtonPressed(BuildContext context) {
     Utils.checkConnectivity().then((value) {
      if (value) {
        if (_validation(context)) {
          _loginBloc.doLogin(
              _emailController.text, _passwordController.text, context);
//          _loginBloc.getUserDetails('1', context);
        }
      } else {
        Utils.showSnackBar(
            Strings.please_check_your_internet_connection, context);
      }
    });
  }

  void _forgotPasswordPressed() {
    print('sldflkf');
    Navigator.pushNamed(context, Strings.FORGOT_PASSWORD_ROUTE);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ));

    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.Login),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: AppColors.transparent,
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Dimens.FORTY),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: Dimens.ONE_TWO_FIVE,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate(Strings.login)
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontSize: Dimens.FORTY_TWO,
                                  letterSpacing: 3.2,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: Strings.EXO_FONT,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.white),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: Dimens.FIFTEEN),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate(Strings.access_your_account),
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontFamily: Strings.EXO_FONT,
                                  fontWeight: FontWeight.w700,
                                  fontSize: Dimens.FORTEEN),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(right: Dimens.TWELVE),
                        child: Center(
                            child: Image.asset(
                          Images.CircleCropped,
                          height: Dimens.sixty,
                          width: Dimens.sixty,
                        )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimens.ONE_TWO_FIVE,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: Dimens.TWENTY,
                      ),
                      Text(
                        AppLocalizations.of(context).translate(Strings.email),
                        style: TextStyle(
                            letterSpacing: 1,
                            fontFamily: Strings.EXO_FONT,
                            fontSize: Dimens.fifteen,
                            fontWeight: FontWeight.w600,
                            color: AppColors.light_text),
                      ),
                      TextField(
                        decoration: InputDecoration(
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
                              fontSize: Dimens.SIXTEEN,
                              color: AppColors.light_text),
                        ),
                        style: TextStyle(
                            fontFamily: Strings.EXO_FONT,
                            fontWeight: FontWeight.w600,
                            fontSize: Dimens.SIXTEEN,
                            color: AppColors.black_text),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                      ),
                      Divider(
                        color: AppColors.divider_color,
                      ),
                      SizedBox(
                        height: Dimens.TWENTY,
                      ),
                      Text(
                        AppLocalizations.of(context)
                            .translate(Strings.password),
                        style: TextStyle(
                            letterSpacing: 1,
                            fontFamily: Strings.EXO_FONT,
                            fontSize: Dimens.fifteen,
                            fontWeight: FontWeight.w600,
                            color: AppColors.light_text),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)
                              .translate(Strings.enter_your_password),
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
                        ),
                        style: TextStyle(
                            fontFamily: Strings.EXO_FONT,
                            fontWeight: FontWeight.w600,
                            fontSize: Dimens.SIXTEEN,
                            color: AppColors.black_text),
                        obscureText: true,
                        controller: _passwordController,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => FocusScope.of(context).unfocus(),
                      ),
                      Divider(
                        color: AppColors.divider_color,
                      ),
                      SizedBox(
                        height: Dimens.FORTY,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: _forgotPasswordPressed,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.dark_gray,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimens.THIRTY)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimens.THIRTY,
                                  vertical: Dimens.thrteen),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate(Strings.forgot_password),
                                style: TextStyle(
                                    letterSpacing: 1,
                                    fontFamily: Strings.EXO_FONT,
                                    fontWeight: FontWeight.w700,
                                    fontSize: Dimens.forteen,
                                    color: AppColors.light_text),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimens.ONE_TWO_FIVE,
                  ),
                  _loginButton(),
                  SizedBox(
                    height: Dimens.twenty,
                  )
                ],
              ),
            ),
          ),
        ),
        StreamBuilder<bool>(
          stream: _loginBloc.progressStream,
          builder: (context, snapshot) {
            return Center(
                child: CommonProgressIndicator(
                    snapshot.hasData ? snapshot.data : false));
          },
        ),
      ],
    );
  }

  Widget _loginButton() {
    return Builder(
      builder: (context) => CustomRaisedButton(
        key: loginButtonKey,
        text:
            AppLocalizations.of(context).translate(Strings.login).toUpperCase(),
        backgroundColor: AppColors.pink_stroke,
        height: Dimens.fiftyThree,
        width: MediaQuery.of(context).size.width,
        borderRadius: Dimens.THIRTY,
        onPressed: () {
          _loginButtonPressed(context);
        },
        isGradient: true,
        loading: isLoading,
        textStyle: TextStyle(
          fontSize: Dimens.fifteen,
          letterSpacing: 1.12,
          color: AppColors.white,
          fontWeight: FontWeight.w700,
          fontFamily: Strings.EXO_FONT,
        ),
      ),
    );
  }
}
