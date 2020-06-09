import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/customviews/CustomViews.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Keys.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';

class WarmUpCompleted extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WarmUpCompletedState();
}

class _WarmUpCompletedState extends State<WarmUpCompleted> {
  static const Key gradientLoadingKey = Key(Keys.gradientLoadingKey);
  static const Key grayLoadingKey = Key(Keys.gradientLoadingKey);
  bool gradientLoading = false;
  bool grayLoading = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 37),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(Images.ICON_WARM_UP),
            SizedBox(
              height: 35,
            ),
            Text(
              'WARM UP',
              style: TextStyle(
                  fontSize: Dimens.THIRTY_SEVEN,
                  fontFamily: Strings.EXO_FONT,
                  letterSpacing: 2.88,
                  color: AppColors.black_text,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w900),
            ),
            Text(
              'ABGESCHLOSSEN!',
              style: TextStyle(
                  fontSize: Dimens.TWENTY_SIX,
                  fontFamily: Strings.EXO_FONT,
                  letterSpacing: 2.08,
                  color: AppColors.black_text,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 35,
            ),
            Text(
              'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              style: TextStyle(
                  fontSize: Dimens.FORTEEN,
                  fontFamily: Strings.EXO_FONT,
                  color: AppColors.light_text,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 70,
            ),
            _gradientButton(),
            SizedBox(
              height: 20,
            ),
            _grayButton()
          ],
        ),
      ),
    );
  }

  Widget _gradientButton() {
    return Builder(
      builder: (context) => CustomRaisedButton(
        key: gradientLoadingKey,
        text: 'ZUM HAUPTprogramm'.toUpperCase(),
        backgroundColor: AppColors.pink_stroke,
        height: Dimens.SIXTY,
        width: MediaQuery.of(context).size.width,
        borderRadius: Dimens.THIRTY,
        onPressed: () {
          _gradientLoadingClick(context);
        },
        isGradient: true,
        loading: gradientLoading,
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

  void _gradientLoadingClick(BuildContext context) {
    setState(() {
      gradientLoading = gradientLoading ? false : true;
    });
  }

  Widget _grayButton() {
    return Builder(
      builder: (context) => CustomRaisedButton(
        key: grayLoadingKey,
        text: 'ABBRECHEN'.toUpperCase(),
        backgroundColor: AppColors.light_gray,
        height: Dimens.SIXTY,
        width: MediaQuery.of(context).size.width,
        borderRadius: Dimens.THIRTY,
        onPressed: () {
          _grayLoadingClick(context);
        },
        isGradient: false,
        loading: grayLoading,
        textStyle: TextStyle(
          fontSize: Dimens.FORTEEN,
          letterSpacing: 1.12,
          color: AppColors.black_text,
          fontWeight: FontWeight.w700,
          fontFamily: Strings.EXO_FONT,
        ),
      ),
    );
  }

  void _grayLoadingClick(BuildContext context) {
    setState(() {
      grayLoading = grayLoading ? false : true;
    });
  }
}
