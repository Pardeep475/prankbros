import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/customviews/CustomViews.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Keys.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';

class ProfileWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  static const Key profileSaveKey = Key(Keys.profileSaveKey);
  TextEditingController _firstNameController,
      _lastNameController,
      _emailController;
  bool _saveButtonLoading = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimens.TWENTY),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: Dimens.sixtyFive,
          ),
          Text(
            AppLocalizations.of(context).translate(Strings.FullName),
            style: TextStyle(
                letterSpacing: 1,
                fontFamily: Strings.EXO_FONT,
                fontWeight: FontWeight.w700,
                fontSize: Dimens.fifteen,
                color: AppColors.light_text),
          ),
          SizedBox(
            height: Dimens.five,
          ),
          TextField(
            minLines: 1,
            maxLines: 1,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0.0),
              isDense: true,
              hintText: AppLocalizations.of(context)
                  .translate(Strings.enter_your_first_name),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintStyle: TextStyle(
                  fontFamily: Strings.EXO_FONT,
                  fontWeight: FontWeight.w700,
                  fontSize: Dimens.SIXTEEN,
                  color: AppColors.light_text),
              labelStyle: TextStyle(
                  fontFamily: Strings.EXO_FONT,
                  fontWeight: FontWeight.w700,
                  fontSize: Dimens.SIXTEEN,
                  color: AppColors.black_text),
            ),
            controller: _firstNameController,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
          ),
          SizedBox(
            height: Dimens.five,
          ),
          Divider(
            color: AppColors.divider_color,
          ),
          SizedBox(
            height: Dimens.FIFTEEN,
          ),
          Text(
            AppLocalizations.of(context).translate(Strings.LastName),
            style: TextStyle(
                letterSpacing: 1,
                fontFamily: Strings.EXO_FONT,
                fontWeight: FontWeight.w700,
                fontSize: Dimens.fifteen,
                color: AppColors.light_text),
          ),
          SizedBox(
            height: Dimens.five,
          ),
          TextField(
            minLines: 1,
            maxLines: 1,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0.0),
              isDense: true,
              hintText: AppLocalizations.of(context)
                  .translate(Strings.enter_your_last_name),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintStyle: TextStyle(
                  fontFamily: Strings.EXO_FONT,
                  fontWeight: FontWeight.w700,
                  fontSize: Dimens.SIXTEEN,
                  color: AppColors.light_text),
              labelStyle: TextStyle(
                  fontFamily: Strings.EXO_FONT,
                  fontWeight: FontWeight.w700,
                  fontSize: Dimens.SIXTEEN,
                  color: AppColors.black_text),
            ),
            controller: _lastNameController,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
          ),
          SizedBox(
            height: Dimens.five,
          ),
          Divider(
            color: AppColors.divider_color,
          ),
          SizedBox(
            height: Dimens.FIFTEEN,
          ),
          Text(
            AppLocalizations.of(context).translate(Strings.E_Mail),
            style: TextStyle(
                letterSpacing: 1,
                fontFamily: Strings.EXO_FONT,
                fontWeight: FontWeight.w700,
                fontSize: Dimens.fifteen,
                color: AppColors.light_text),
          ),
          SizedBox(
            height: Dimens.five,
          ),
          TextField(
            minLines: 1,
            maxLines: 1,
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
                  fontWeight: FontWeight.w700,
                  fontSize: Dimens.SIXTEEN,
                  color: AppColors.light_text),
              labelStyle: TextStyle(
                  fontFamily: Strings.EXO_FONT,
                  fontWeight: FontWeight.w700,
                  fontSize: Dimens.SIXTEEN,
                  color: AppColors.black_text),
            ),
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => FocusScope.of(context).unfocus(),
          ),
          SizedBox(
            height: Dimens.five,
          ),
          Divider(
            color: AppColors.divider_color,
          ),
          SizedBox(
            height: Dimens.HUNDRUD,
          ),
          _saveButton(),
        ],
      ),
    );
  }

  Widget _saveButton() {
    return Builder(
      builder: (context) => CustomRaisedButton(
        key: profileSaveKey,
        text:
            AppLocalizations.of(context).translate(Strings.Save).toUpperCase(),
        backgroundColor: AppColors.pink_stroke,
        height: Dimens.SIXTY,
        width: MediaQuery.of(context).size.width,
        borderRadius: Dimens.THIRTY,
        onPressed: _profileSavePressed,
        isGradient: true,
        loading: _saveButtonLoading,
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

  void _profileSavePressed() {
    print('Profile Saved !');
    setState(() {
      _saveButtonLoading = _saveButtonLoading ? false : true;
    });
  }


}
