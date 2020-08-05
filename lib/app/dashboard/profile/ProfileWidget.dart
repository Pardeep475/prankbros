import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/profile/updateprofile/UpdateProfileBloc.dart';
import 'package:prankbros2/customviews/CustomViews.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Keys.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Utils.dart';
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
  UpdateProfileBloc _updateProfileBloc;
  SessionManager _sessionManager;
  String userId = '';
  String accessToken = '';

  @override
  void initState() {
    super.initState();
    _updateProfileBloc = new UpdateProfileBloc();
    _sessionManager = new SessionManager();
    _updateValues();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
  }

  void _updateValues() {
    _sessionManager.getUserModel().then((value) {
      debugPrint("userdata   :        ${value}");
      if (value != null) {
        UserDetails userData = UserDetails.fromJson(value);
        debugPrint('userdata:   :-  ${userData.id}     ${userData.email}');
        userId = userData.id.toString();
        accessToken = userData.accessToken.toString();
        _firstNameController.text =
            userData.firstName != null ? userData.firstName : '';
        _lastNameController.text =
            userData.lastName != null ? userData.lastName : '';
        _emailController.text = userData.email != null ? userData.email : '';
        setState(() {});
      }
    });
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
            readOnly: true,
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
                  fontWeight: FontWeight.w600,
                  fontSize: Dimens.SIXTEEN,
                  color: AppColors.light_text),
            ),
            style: TextStyle(
                fontFamily: Strings.EXO_FONT,
                fontWeight: FontWeight.w600,
                fontSize: Dimens.SIXTEEN,
                color: AppColors.black_text),
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
            readOnly: true,
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
                  fontWeight: FontWeight.w600,
                  fontSize: Dimens.SIXTEEN,
                  color: AppColors.light_text),
            ),
            style: TextStyle(
                fontFamily: Strings.EXO_FONT,
                fontWeight: FontWeight.w600,
                fontSize: Dimens.SIXTEEN,
                color: AppColors.black_text),
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
            readOnly: true,
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
//          _saveButton(),
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
        onPressed: () {
          _profileSavePressed(context);
        },
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

  void _profileSavePressed(BuildContext context) {
    print('Profile Saved !');
    setState(() {
      _saveButtonLoading = true;
    });

    Utils.checkConnectivity().then((value) {
      if (value) {
        if (_validation(context)) {
          _updateProfileBloc
              .updateUserProfile(
                  userId: userId,
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  email: _emailController.text,
                  context: context,
                  accessToken: accessToken)
              .then((value) {
            setState(() {
              _saveButtonLoading = false;
            });
            debugPrint('after api hit');
          });
        }
      } else {
        Utils.showSnackBar(
            Strings.please_check_your_internet_connection, context);
      }
    });
  }

  /*
  * userId, ,
                  _lastNameController.text, _emailController.text, context
  * 
  * */

  bool _validation(BuildContext context) {
    if (Utils.checkNullOrEmpty(_firstNameController.text)) {
      Utils.showSnackBar('Please enter your first name', context);
      return false;
    } else if (Utils.checkNullOrEmpty(_lastNameController.text)) {
      Utils.showSnackBar('Please enter your last name', context);
      return false;
    } else if (Utils.checkNullOrEmpty(_emailController.text)) {
      Utils.showSnackBar("please enter your email.", context);
      return false;
    }
    return true;
  }
}
