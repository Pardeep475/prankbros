import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/profile/changelanguage/ChangeLanguageBloc.dart';
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

class CustomLanguageDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomLanguageDialog();
}

class _CustomLanguageDialog extends State<CustomLanguageDialog> {
  static const Key changeLanguageKey = Key(Keys.changeLanguageKey);
  bool isLoading = false;
  int language = 0; // 0 for Deutch, 1 for ENGLISH
  SessionManager _sessionManager;
  String userId = '';
  ChangeLanguageBloc _changeLanguageBloc;

  @override
  void initState() {
    super.initState();
    _changeLanguageBloc = new ChangeLanguageBloc();
    _sessionManager = new SessionManager();
    _sessionManager.getUserModel().then((value) {
      if (value != null) {
        UserDetails userData = UserDetails.fromJson(value);
        userId = userData.id.toString();
        if(userData.language.compareTo('ENGLISH')== 0){
          language = 1;
        }else{
          language = 0;
        }
        setState(() {

        });
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
                                AppLocalizations.of(context)
                                    .translate(Strings.LANGUAGE),
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
                          height: Dimens.FORTY_FOUR,
                        ),
                        GestureDetector(
                          onTap: () {
                            _selectLanguage(0);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: Dimens.TWENTY_TWO,
                                width: Dimens.TWENTY_TWO,
                                child: CircleAvatar(
                                  radius: Dimens.TWENTY_TWO,
                                  backgroundColor: language == 0
                                      ? AppColors.selectedRadioColor
                                      : AppColors.unSelectedRadioColor,
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.backRadioColor,
                                    radius: language == 0 ? Dimens.SIX : Dimens.TEN,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Dimens.FIFTEEN,
                              ),
                              Image.asset(Images.LANG_DEUTCH),
                              SizedBox(
                                width: Dimens.FIFTEEN,
                              ),
                              Text(
                                'Deutch'.toUpperCase(),
                                    style: TextStyle(
                                    letterSpacing: 1.04,
                                    color: language == 0 ? AppColors.black_text:AppColors.unSelectedTextRadioColor,
                                    fontSize: Dimens.THRTEEN,
                                    fontFamily: Strings.EXO_FONT,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Dimens.TWENTY_FIVE,
                        ),
                        Divider(
                          height: Dimens.ONE,
                        ),
                        SizedBox(
                          height: Dimens.TWENTY_FIVE,
                        ),
                        GestureDetector(
                          onTap: () {
                            _selectLanguage(1);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: Dimens.TWENTY_TWO,
                                width: Dimens.TWENTY_TWO,
                                child: CircleAvatar(
                                  radius: Dimens.TWENTY_TWO,
                                  backgroundColor: language == 1
                                      ? AppColors.selectedRadioColor
                                      : AppColors.unSelectedRadioColor,
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.backRadioColor,
                                    radius: language == 1 ? Dimens.SIX : Dimens.TEN,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Dimens.FIFTEEN,
                              ),
                              Image.asset(Images.LANG_ENGLISH),
                              SizedBox(
                                width: Dimens.FIFTEEN,
                              ),
                              Text(
                                'English'.toUpperCase(),
                                style: TextStyle(
                                    letterSpacing: 1.04,
                                    color: language == 1 ? AppColors.black_text:AppColors.unSelectedTextRadioColor,
                                    fontSize: Dimens.THRTEEN,
                                    fontFamily: Strings.EXO_FONT,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Dimens.THIRTY,
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: Dimens.FORTY),
                          child: _changeLanguageButton(),
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

  void _changeLanguage(BuildContext context) {
    print('clicked   $isLoading');
    setState(() {
      isLoading = true;
    });
    changeLanguage();
  }

  void _selectLanguage(int langValue) {
    setState(() {
      language = langValue;
    });
  }

  void changeLanguage() {
    if (userId == null || userId.isEmpty) {
      Utils.showSnackBar('Something went wrong.', context);
      return;
    }
    var languageString = 'DEUTCH';
    if (language == 0){
      languageString = 'DEUTCH';
    }else{
      languageString = 'ENGLISH';
    }
    debugPrint("language code ----->   ${languageString}");
    Utils.checkConnectivity().then((value) {
      if (value) {
        _changeLanguageBloc.changeLanguage(userId,languageString, context);
      } else {
        Navigator.pop(context);
        Utils.showSnackBar(
            Strings.please_check_your_internet_connection, context);
      }
    });
  }


  void _dismissLanguagePopUp(BuildContext context) {
    Navigator.pop(context);
  }

  Widget _changeLanguageButton() {
    return Builder(
      builder: (context) => CustomRaisedButton(
        key: changeLanguageKey,
        text: "SPEICHERN",
        backgroundColor: AppColors.pink_stroke,
        height: Dimens.SIXTY,
        width: MediaQuery.of(context).size.width,
        borderRadius: Dimens.THIRTY,
        onPressed: () {
          _changeLanguage(context);
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
