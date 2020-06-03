import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:prankbros2/app/auth/login/Login.dart';
import 'package:prankbros2/customviews/CustomViews.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Keys.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';

import 'IntroItem.dart';
import 'IntroItemFirst.dart';

class Intro extends StatefulWidget {
  SessionManager sessionManager = new SessionManager();

  @override
  State<StatefulWidget> createState() => _IntoState(sessionManager);
}

class _IntoState extends State<Intro> {
  static const Key loginIntroKey = Key(Keys.loginIntroKey);

  SessionManager sessionManager;

  _IntoState(this.sessionManager);

  final List<String> titles = [
    Strings.empty,
    Strings.WalkThroughT2,
    Strings.WalkThroughT3,
    Strings.WalkThroughT4
  ];
  final List<String> subTitles = [
    Strings.empty,
    Strings.WalkThroughST2,
    Strings.WalkThroughST3,
    Strings.WalkThroughST4
  ];

  Widget _selectedWidget(int index) {
    if (index == 0) {
      return IntroItemFirst(
          bg: Colors.blue.shade300, imageUrl: getImageFromIndex(index));
    } else {
      return IntroItem(
          title: titles[index],
          subTitle: subTitles[index],
          bg: Colors.blue.shade300,
          imageUrl: getImageFromIndex(index));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    /*WidgetsFlutterBinding.ensureInitialized();
    var appLanguage = Provider.of<AppLanguage>(context);*/
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Swiper(
            pagination: SwiperPagination(
                margin: EdgeInsets.only(bottom: Dimens.ONE_EIGHTY_THREE),
                alignment: Alignment.bottomCenter,
                builder: DotSwiperPaginationBuilder(
                    activeColor: Colors.white,
                    color: Colors.white70,
                    size: Dimens.FORTEEN,
                    space: Dimens.TEN,
                    activeSize: Dimens.FORTEEN)),
            itemCount: 4,
            loop: true,
            itemBuilder: (context, index) {
              return _selectedWidget(index);
            },
          ),
          Container(
            margin: EdgeInsets.only(
                left: Dimens.FORTY, bottom: Dimens.FORTY, right: Dimens.FORTY),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _loginButton(),
            ),
          )
        ],
      ),
    );
  }

  Widget _loginButton() {
    return CustomRaisedButton(
      key: loginIntroKey,
      text: AppLocalizations.of(context).translate(Strings.login).toUpperCase(),
      backgroundColor: AppColors.white,
      height: Dimens.SIXTY,
      width: MediaQuery.of(context).size.width,
      borderRadius: Dimens.THIRTY,
      onPressed: _loginButtonPressed,
      isGradient: false,
      loading: false,
      textStyle: TextStyle(
          fontSize: Dimens.SEVENTEEN,
          letterSpacing: 2,
          color: AppColors.light_text,
          fontFamily: Strings.EXO_FONT,
          fontWeight: FontWeight.w700),
    );
  }

  void _loginButtonPressed() {
    sessionManager.setInstalledFirstTime(true);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  String getImageFromIndex(int index) {
    var url = Images.One;

    switch (index) {
      case 0:
        {
          url = Images.One;
        }
        break;
      case 1:
        {
          url = Images.Two;
        }
        break;
      case 2:
        {
          url = Images.Three;
        }
        break;
      case 3:
        {
          url = Images.Four;
        }
        break;
      default:
        {
          url = Images.One;
        }
        break;
    }
    return url;
  }
}
