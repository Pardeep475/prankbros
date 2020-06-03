import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/customviews/CustomViews.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Keys.dart';
import 'package:prankbros2/utils/Strings.dart';

class CustomResetYourProgramDialog extends StatefulWidget {

  CustomResetYourProgramDialog({this.title, this.value});

  final String title;
  final int value;

  @override
  State<StatefulWidget> createState() {
    print('title is : $title  value is : $value');
    return   _CustomResetYourProgramDialog(this.title, this.value);
  }

}

class _CustomResetYourProgramDialog
    extends State<CustomResetYourProgramDialog> {
  _CustomResetYourProgramDialog(this.title, this.value);

  @override
  initState() {
    super.initState();
  }

  String title;
  int value; // 0 for reset your program

  static const Key yesResetKey = Key(Keys.yesResetKey);
  static const Key noResetKey = Key(Keys.noResetKey);
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimens.TWENTY),
      child: Center(
        child: Card(
          elevation: Dimens.FIVE,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.FORTY),
          ),
          child: Wrap(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        _dismissLanguagePopUp(context);
                      },
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimens.FORTY)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Dimens.TWENTY, right: Dimens.TWENTY_FIVE),
                        child: Image.asset(
                          Images.ICON_CROSS,
                          height: Dimens.THIRTY,
                          width: Dimens.THIRTY,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimens.TWENTY_FIVE,
                  ),
                  Text(
                    this.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.black_text,
                        fontWeight: FontWeight.w700,
                        fontFamily: Strings.EXO_FONT,
                        fontSize: Dimens.TWENTY_SIX),
                  ),
                  SizedBox(
                    height: Dimens.THIRTY,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimens.TWENTY, vertical: Dimens.TWENTY),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: _noButton(),
                        ),
                        SizedBox(
                          width: Dimens.TEN,
                        ),
                        Expanded(
                          child: _yesButton(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimens.TWENTY,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _noButton() {
    return Builder(
      builder: (context) => CustomRaisedButton(
        key: noResetKey,
        text: "No".toUpperCase(),
        backgroundColor: AppColors.dark_gray,
        height: Dimens.FIFTY,
        width: MediaQuery.of(context).size.width,
        borderRadius: Dimens.THIRTY,
        onPressed: () {
          _dismissLanguagePopUp(context);
        },
        isGradient: false,
        loading: false,
        textStyle: TextStyle(
          fontSize: Dimens.FIFTEEN,
          letterSpacing: 1.12,
          color: AppColors.light_text,
          fontWeight: FontWeight.w700,
          fontFamily: Strings.EXO_FONT,
        ),
      ),
    );
  }

  Widget _yesButton() {
    return Builder(
      builder: (context) => CustomRaisedButton(
        key: yesResetKey,
        text: "Yes".toUpperCase(),
        backgroundColor: AppColors.pink_stroke,
        height: Dimens.FIFTY,
        width: MediaQuery.of(context).size.width,
        borderRadius: Dimens.THIRTY,
        onPressed: _yesButtonClick,
        isGradient: true,
        loading: isLoading,
        textStyle: TextStyle(
          fontSize: Dimens.FIFTEEN,
          letterSpacing: 1.12,
          color: AppColors.white,
          fontWeight: FontWeight.w700,
          fontFamily: Strings.EXO_FONT,
        ),
      ),
    );
  }

  void _dismissLanguagePopUp(BuildContext context) {
    Navigator.pop(context);
  }

  void _yesButtonClick() {
    setState(() {
      // saprate login for different
      isLoading = isLoading ? false : true;
    });
  }
}
