import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/profile/weightcurve/WeightCurveBloc.dart';
import 'package:prankbros2/customviews/CustomViews.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/models/userweight/GetUserWeightApiResponse.dart';
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
  UserProfileWeights item;

  CustomUpdateWeightDialog({this.index, this.item});

  @override
  State<StatefulWidget> createState() =>
      _CustomUpdateWeightDialog(index: index, item: item);
}

class _CustomUpdateWeightDialog extends State<CustomUpdateWeightDialog> {
  static const Key changeLanguageKey = Key(Keys.changeLanguageKey);
  bool isLoading = false;
  int language = 0; // 0 for Deutch, 1 for ENGLISH
  UserProfileWeights item;
  final int index;

  _CustomUpdateWeightDialog({this.index, this.item});

  WeightCurveBloc _weightCurveBloc;
  SessionManager _sessionManager;
  String userId = '';
  String accessToken = '';
  String weight = '50,0';
  bool _buttonPressed = false;
  bool _loopActive = false;

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
        accessToken = userData.accessToken.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                            Listener(
                              onPointerDown: (details) {
                                _buttonPressed = true;
                                _minusButtonLongClick();
                              },
                              onPointerUp: (details) {
                                _buttonPressed = false;
                              },
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
                            Listener(
                              onPointerDown: (details) {
                                _buttonPressed = true;
                                _plusButtonLongClick();
                              },
                              onPointerUp: (details) {
                                _buttonPressed = false;
                              },
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
    if (userId == null || userId.isEmpty) {
      Utils.showToast('Something went wrong.', context);
      return;
    }
    if (item == null || item.createdOn == null || item.createdOn.isEmpty) {
      Utils.showToast('Date not specified', context);
      return;
    }
    Utils.checkConnectivity().then((value) {
      if (value) {
        setState(() {
          isLoading = isLoading ? false : true;
        });
        _weightCurveBloc.addWeightCurve(
            userId: userId,
            widget: weight,
            createdOn: item.createdOn,
            context: context,
            accessToken: accessToken);
      } else {
        Navigator.pop(context);
        Utils.showToast(Strings.please_check_your_internet_connection, context);
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

  void _plusButtonLongClick() async {
    // make sure that only one loop is active
    if (_loopActive) return;

    _loopActive = true;

    while (_buttonPressed) {
      // do your thing
      setState(() {
        double value = double.parse(weight.replaceAll(',', '.'));
        value = value * 10;
        value++;
        value = value / 10;
        weight = value.toStringAsFixed(1).replaceAll('.', ',');
        setState(() {});
      });

      // wait a bit
      await Future.delayed(Duration(milliseconds: 100));
    }

    _loopActive = false;

    debugPrint('long plus press icon click   -----plus');
    try {} catch (e) {
      debugPrint(e.toString());
    }
  }

  void _minusButtonLongClick() async {
    // make sure that only one loop is active
    if (_loopActive) return;

    _loopActive = true;

    while (_buttonPressed) {
      // do your thing
      setState(() {
        double value = double.parse(weight.replaceAll(',', '.'));
        value = value * 10;
        value--;
        value = value / 10;
        weight = value.toStringAsFixed(1).replaceAll('.', ',');
        setState(() {});
      });

      // wait a bit
      await Future.delayed(Duration(milliseconds: 100));
    }

    _loopActive = false;

    debugPrint('long plus press icon click   -----plus');
    try {} catch (e) {
      debugPrint(e.toString());
    }
  }

  void _plusButtonClick() {
    debugPrint('plus icon click');
    try {
      double value = double.parse(weight.replaceAll(',', '.'));
      value = value * 10;
      value++;
      value = value / 10;
      weight = value.toStringAsFixed(1).replaceAll('.', ',');
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
      value = value * 10;
      value--;
      value = value / 10;
      weight = value.toStringAsFixed(1).replaceAll('.', ',');
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

/*
  * "{
        ""userId"":1,
        ""weight"":""57,2"",
        ""createdOn"":""2020-07-29""
}"
  *
  * */

}
