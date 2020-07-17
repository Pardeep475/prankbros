import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/profile/weightcurve/WeightCurveBloc.dart';
import 'package:prankbros2/customviews/CustomViews.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Keys.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Utils.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';

class CustomUpdateWeightDialog extends StatefulWidget {
  final int index;

  CustomUpdateWeightDialog({this.index});

  @override
  State<StatefulWidget> createState() =>
      _CustomUpdateWeightDialog(index: index);
}

class _CustomUpdateWeightDialog extends State<CustomUpdateWeightDialog> {
  static const Key changeLanguageKey = Key(Keys.changeLanguageKey);
  bool isLoading = false;
  int language = 0; // 0 for Deutch, 1 for ENGLISH

  final int index;

  _CustomUpdateWeightDialog({this.index});

  WeightCurveBloc _weightCurveBloc;
  SessionManager _sessionManager;
  String userId = '';
  String weight = '00,0';

  @override
  void initState() {
    super.initState();
    _weightCurveBloc = new WeightCurveBloc();
    _sessionManager = new SessionManager();
    _sessionManager.getUserModel().then((value) {
      debugPrint("userdata   :        ${value}");
      if (value != null) {
        UserDetails userData = UserDetails.fromJson(value);
        debugPrint('userdata:   :-  ${userData.id}     ${userData.email}');
        userId = userData.id.toString();
      }
    });
  }

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
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimens.thirty)),
                              child: Container(
                                height: Dimens.twentyEight,
                                width: Dimens.twentyEight,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Dimens.thirty)),
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
                              weight,
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
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimens.thirty)),
                              child: Container(
                                height: Dimens.twentyEight,
                                width: Dimens.twentyEight,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Dimens.thirty)),
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

    if (userId == null || userId.isEmpty) {
      Utils.showSnackBar('Something went wrong.', context);
      return;
    }
    Utils.checkConnectivity().then((value) {
      if (value) {
        _weightCurveBloc.addWeightCurve(userId, weight, context);
      } else {
        Navigator.pop(context);
        Utils.showSnackBar(
            Strings.please_check_your_internet_connection, context);
      }
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

  void _plusButtonClick() {
    debugPrint('plus icon click');
    try {
      double value = double.parse(weight.replaceAll(',', '.'));
      value++;
      weight = value.toString().replaceAll('.', ',');
      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _minusButtonClick() {
    debugPrint('plus icon click');
    try {
      double value = double.parse(weight.replaceAll(',', '.'));
      if (value <= 0) return;
      value--;
      weight = value.toString().replaceAll('.', ',');
      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
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
