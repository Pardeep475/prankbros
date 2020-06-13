import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/customviews/CustomViews.dart';
import 'package:prankbros2/popups/CustomLanguageDialog.dart';
import 'package:prankbros2/popups/CustomResetYourProgramDialog.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Keys.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';

class SettingsWidget extends StatelessWidget {
  static const Key profileSaveKey = Key(Keys.profileSaveKey);
  static const Key languageKey = Key(Keys.languageKey);
  static const Key supportKey = Key(Keys.supportKey);
  static const Key dataProtectionKey = Key(Keys.dataProtectionKey);
  static const Key impressumKey = Key(Keys.impressumKey);
  static const Key agbKey = Key(Keys.AGBKey);
  static const Key logoutKey = Key(Keys.logoutKey);
  static const Key resetMyProgramKey = Key(Keys.resetMyProgramKey);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: Dimens.sixtyFive,
            ),
            CustomSettingButton(
                key: languageKey,
                text: AppLocalizations.of(context).translate(Strings.LANGUAGE),
                onPressed: () {
                  _languagePressed(context);
                }),
            DividerWidget(),
            CustomSettingButton(
                key: supportKey,
                text: AppLocalizations.of(context).translate(Strings.SUPPORT),
                onPressed: _supportPressed),
            DividerWidget(),
            CustomSettingButton(
                key: dataProtectionKey,
                text: AppLocalizations.of(context)
                    .translate(Strings.DATA_PROTECTION),
                onPressed: _dataProtectionPressed),
            DividerWidget(),
            CustomSettingButton(
                key: impressumKey,
                text: AppLocalizations.of(context).translate(Strings.IMPRESSUM),
                onPressed: _impressumPressed),
            DividerWidget(),
            CustomSettingButton(
                key: agbKey,
                text: AppLocalizations.of(context).translate(Strings.AGB),
                onPressed: _agbPressed),
            DividerWidget(),
            SizedBox(
              height: Dimens.SIXTY,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.TWENTY),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _logoutButton(),
                  ),
                  SizedBox(
                    width: Dimens.TEN,
                  ),
                  Expanded(
                    child: _resetMyProgramButton(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget DividerWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.TEN),
      child: Divider(
        height: Dimens.ONE,
        color: AppColors.divider_color,
      ),
    );
  }

  Widget _logoutButton() {
    return Builder(
      builder: (context) => CustomRaisedButton(
        key: logoutKey,
        text: AppLocalizations.of(context).translate(Strings.LOGOUT),
        backgroundColor: AppColors.dark_gray,
        height: Dimens.FIFTY,
        width: MediaQuery.of(context).size.width,
        borderRadius: Dimens.THIRTY,
        onPressed: () {
          _logout(context);
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

  Widget _resetMyProgramButton() {
    return Builder(
      builder: (context) => CustomRaisedButton(
        key: resetMyProgramKey,
        text: AppLocalizations.of(context).translate(Strings.RESET_MY_PROGRAM),
        backgroundColor: AppColors.dark_gray,
        height: Dimens.FIFTY,
        width: MediaQuery.of(context).size.width,
        borderRadius: Dimens.THIRTY,
        onPressed: () {
          _resetMyProgram(context);
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

  void _logout(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => CustomResetYourProgramDialog(
              title: "Are you sure want to logout?",
              value: 1,
              yesPressed: () {
                SessionManager sessionManager = new SessionManager();
                sessionManager.clearAllData();
                Navigator.pushNamedAndRemoveUntil(
                    context, Strings.LOGIN_ROUTE, (route) => false);
              },
            ));
  }

  void _resetMyProgram(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => CustomResetYourProgramDialog(
              title: "Are you sure want to reset program?",
              value: 0,
              yesPressed: () {
                Navigator.pop(context);
              },
            ));
  }

  void _languagePressed(BuildContext context) {
    showDialog(context: context, builder: (_) => CustomLanguageDialog());
  }

  void _supportPressed() {
    print('support!');
  }

  void _dataProtectionPressed() {
    print('data protection!');
  }

  void _impressumPressed() {
    print('Impressum!');
  }

  void _agbPressed() {
    print('agb!');
  }
}
