import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/customviews/CustomViews.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Keys.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';

class CustomUpdateWeightDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomUpdateWeightDialog();
}

class _CustomUpdateWeightDialog extends State<CustomUpdateWeightDialog> {
  static const Key changeLanguageKey = Key(Keys.changeLanguageKey);
  bool isLoading = false;
  int language = 0; // 0 for Deutch, 1 for ENGLISH

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
              Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      Images.POPUP_GRAY_BACK,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: Dimens.TWENTY,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: Dimens.TWENTY_FIVE,
                            ),
                            Expanded(
                              child: Text(
                                'Update your weight',
                                style: TextStyle(
                                    color: AppColors.black_text,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: Strings.EXO_FONT,
                                    fontSize: Dimens.TWENTY_SIX),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _dismissLanguagePopUp(context);
                              },
                              child: Image.asset(
                                Images.ICON_CROSS,
                                height: Dimens.THIRTY,
                                width: Dimens.THIRTY,
                              ),
                            ),
                            SizedBox(
                              width: Dimens.TWENTY_FIVE,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimens.SEVENTY,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                _minusButtonClick();
                              },
                              borderRadius: BorderRadius.all(Radius.circular(Dimens.thirty)),
                              child: Container(
                                height: Dimens.twentyEight,
                                width: Dimens.twentyEight,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(Dimens.thirty)),
                                    color: AppColors.light_gray),
                                child: Center(
                                  child: Image.asset(
                                    Images.ICON_MINUS,
                                    height: Dimens.twelve,
                                    width: Dimens.twelve,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Dimens.FIFTY_ONE,
                            ),
                            Text(
                              '55,5'.toUpperCase(),
                              style: TextStyle(
                                  letterSpacing: 2.08,
                                  color: AppColors.black_text,
                                  fontSize: Dimens.TWENTY_SIX,
                                  fontFamily: Strings.EXO_FONT,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: Dimens.FIFTY_ONE,
                            ),
                            InkWell(
                              onTap: () {
                                _plusButtonClick();
                              },
                              borderRadius: BorderRadius.all(Radius.circular(Dimens.thirty)),
                              child: Container(
                                height: Dimens.twentyEight,
                                width: Dimens.twentyEight,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(Dimens.thirty)),
                                    color: AppColors.light_gray),
                                child: Center(
                                  child: Image.asset(
                                    Images.ICON_PLUS,
                                    height: Dimens.twelve,
                                    width: Dimens.twelve,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimens.FIFTY,
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: Dimens.FORTY),
                          child: _updateWeightButton(),
                        ),
                        SizedBox(
                          height: Dimens.FORTY,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _updateWeight(BuildContext context) {
    print('clicked   $isLoading');
    setState(() {
      isLoading = isLoading ? false : true;
    });
  }

  void _selectLanguage(int langValue) {
    setState(() {
      language = langValue;
    });
  }

  void _dismissLanguagePopUp(BuildContext context) {
    Navigator.pop(context);
  }

  void _plusButtonClick(){
    debugPrint('plus icon click');
  }

  void _minusButtonClick(){
    debugPrint('plus icon click');
  }

  Widget _updateWeightButton() {
    return Builder(
      builder: (context) => CustomRaisedButton(
        key: changeLanguageKey,
        text:
            AppLocalizations.of(context).translate(Strings.Save).toUpperCase(),
        backgroundColor: AppColors.pink_stroke,
        height: Dimens.SIXTY,
        width: MediaQuery.of(context).size.width,
        borderRadius: Dimens.THIRTY,
        onPressed: () {
          _updateWeight(context);
        },
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
