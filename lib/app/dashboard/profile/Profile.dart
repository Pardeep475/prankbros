import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/customviews/CustomViews.dart';
import 'package:prankbros2/models/WeightCurveModel.dart';
import 'package:prankbros2/popups/CustomChangeWeekDialog.dart';
import 'package:prankbros2/popups/CustomImagePickerDialog.dart';
import 'package:prankbros2/popups/CustomLanguageDialog.dart';
import 'package:prankbros2/popups/CustomResetRedDialog.dart';
import 'package:prankbros2/popups/CustomResetYourProgramDialog.dart';
import 'package:prankbros2/popups/CustomUpdateWeightDialog.dart';
import 'package:prankbros2/popups/TutorialOverlay.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Keys.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';
import 'dart:math' as math;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _firstNameController,
      _lastNameController,
      _emailController;
  static const Key profileSaveKey = Key(Keys.profileSaveKey);
  static const Key languageKey = Key(Keys.languageKey);
  static const Key supportKey = Key(Keys.supportKey);
  static const Key dataProtectionKey = Key(Keys.dataProtectionKey);
  static const Key impressumKey = Key(Keys.impressumKey);
  static const Key agbKey = Key(Keys.AGBKey);
  static const Key logoutKey = Key(Keys.logoutKey);
  static const Key resetMyProgramKey = Key(Keys.resetMyProgramKey);

  bool _saveButtonLoading = false;

  List<WeightCurveModel> weightCurveList = new List<WeightCurveModel>();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _weightCurveList();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _profileSavePressed() {
    print('Profile Saved !');
    setState(() {
      _saveButtonLoading = _saveButtonLoading ? false : true;
    });
  }

  void _logout() {
    showDialog(
        context: context,
        builder: (_) => CustomResetYourProgramDialog(
            title: "Are you sure want to logout?", value: 1));
  }

  void _resetMyProgram() {
    showDialog(
        context: context,
        builder: (_) => CustomResetYourProgramDialog(
            title: "Are you sure want to reset program?", value: 0));
  }

  void _languagePressed() {
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Added
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height),
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  Images.TopBg,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: Dimens.SIXTY,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(
                              left: Dimens.TWENTY_FIVE, right: Dimens.TWENTY),
                          width: Dimens.FIFTY_SIX,
                          height: Dimens.FIFTY_SIX,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new AssetImage(Images.DummyFood),
                              ))),
                      SizedBox(
                        height: Dimens.TWENTY,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'PrankBros',
                            style: TextStyle(
                                fontFamily: Strings.EXO_FONT,
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: Dimens.TWENTY_SEVEN),
                          ),
                          SizedBox(
                            height: Dimens.FIVE,
                          ),
                          Text(
                            'prankbros@app.de',
                            style: TextStyle(
                                fontFamily: Strings.EXO_FONT,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                                fontSize: Dimens.FORTEEN),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: Dimens.TWENTY,
                  ),
                  Divider(
                    color: AppColors.light_gray,
                  ),
                  SizedBox(
                    height: Dimens.TWENTY,
                  ),
                  TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: AppColors.pink,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimens.FIFTY),
                        border: Border.all(
                            color: AppColors.pink_stroke, width: Dimens.ONE)),
                    tabs: <Widget>[
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(AppLocalizations.of(context)
                              .translate(Strings.Profile)),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(AppLocalizations.of(context)
                              .translate(Strings.Pictures)),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(AppLocalizations.of(context)
                              .translate(Strings.WeightCurve)),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(AppLocalizations.of(context)
                              .translate(Strings.Settings)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimens.FORTY,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        _tabsContent(0),
                        _tabsContent(1),
                        _tabsContent(2),
                        _tabsContent(3),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabsContent(int index) {
    switch (index) {
      case 0:
        {
          return _profileWidget();
        }
        break;
      case 1:
        {
          return _picturesWidget();
        }
        break;
      case 2:
        {
          return _weightCurveWidget();
        }
        break;
      case 3:
        {
          return _settingsWidget();
        }
        break;
      default:
        {
          return _profileWidget();
        }
        break;
    }
  }

  Widget _profileWidget() {
    return SingleChildScrollView(
      primary: true,
      physics: ClampingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimens.TWENTY),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: Dimens.THIRTY,
            ),
            Text(
              AppLocalizations.of(context).translate(Strings.FullName),
              style: TextStyle(
                  letterSpacing: 1,
                  fontFamily: Strings.EXO_FONT,
                  fontWeight: FontWeight.w700,
                  fontSize: Dimens.THRTEEN,
                  color: AppColors.light_text),
            ),
            TextField(
              decoration: InputDecoration(
                fillColor: Colors.red,
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
                labelStyle: TextStyle(
                    fontFamily: Strings.EXO_FONT,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimens.SIXTEEN,
                    color: AppColors.black_text),
              ),
              controller: _firstNameController,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(context).nextFocus(),
            ),
            Divider(
              color: AppColors.light_gray,
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
                  fontSize: Dimens.THRTEEN,
                  color: AppColors.light_text),
            ),
            TextField(
              decoration: InputDecoration(
                fillColor: Colors.red,
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
                labelStyle: TextStyle(
                    fontFamily: Strings.EXO_FONT,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimens.SIXTEEN,
                    color: AppColors.black_text),
              ),
              controller: _lastNameController,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(context).nextFocus(),
            ),
            Divider(
              color: AppColors.light_gray,
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
                  fontSize: Dimens.THRTEEN,
                  color: AppColors.light_text),
            ),
            TextField(
              decoration: InputDecoration(
                fillColor: Colors.red,
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
                labelStyle: TextStyle(
                    fontFamily: Strings.EXO_FONT,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimens.SIXTEEN,
                    color: AppColors.black_text),
              ),
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => FocusScope.of(context).unfocus(),
            ),
            Divider(
              color: AppColors.light_gray,
            ),
            SizedBox(
              height: Dimens.HUNDRUD,
            ),
            _saveButton(),
          ],
        ),
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

  Widget _weightCurveWidget() {
    return Wrap(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: Dimens.TWENTY),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.FORTY),
            ),
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return _WeightCurveListItem(index);
                    },
                    childCount: weightCurveList.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget _WeightCurveListItem(int index) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 15,
            ),
            Text(
              weightCurveList[index].timeStamp,
              style: TextStyle(
                color: AppColors.black_text,
                fontSize: Dimens.FORTEEN,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: Text(
                weightCurveList[index].weight,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.light_text,
                  fontSize: Dimens.FORTEEN,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print('click  :-  $index');
              },
              child: Image.asset(
                Images.ICON_CROSS,
                height: Dimens.TWENTY_SIX,
                width: Dimens.TWENTY_SIX,
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Divider(
            height: 1,
            color: (index == weightCurveList.length - 1)
                ? AppColors.transparent
                : AppColors.light_gray)
      ],
    );
  }

  void _weightCurveList() {
    for (int i = 0; i < 10; i++) {
      weightCurveList
          .add(WeightCurveModel(timeStamp: '01.01.2019', weight: '103.5 KG'));
    }
  }

  Widget _picturesWidget() {
    return Container(
      child: Center(
        child: Material(
            child: InkWell(
                onTap: _selectImageButton, child: Image.asset(Images.Cup))),
      ),
    );
  }

  void _selectImageButton() {
    showDialog(context: context, builder: (_) => CustomImagePickerDialog());
  }

  Widget _settingsWidget() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomSettingButton(
                key: languageKey,
                text: AppLocalizations.of(context).translate(Strings.LANGUAGE),
                onPressed: _languagePressed),
            Divider(
              height: Dimens.ONE,
              color: AppColors.dark_gray,
            ),
            CustomSettingButton(
                key: supportKey,
                text: AppLocalizations.of(context).translate(Strings.SUPPORT),
                onPressed: _supportPressed),
            Divider(
              height: Dimens.ONE,
              color: AppColors.dark_gray,
            ),
            CustomSettingButton(
                key: dataProtectionKey,
                text: AppLocalizations.of(context)
                    .translate(Strings.DATA_PROTECTION),
                onPressed: _dataProtectionPressed),
            Divider(
              height: Dimens.ONE,
              color: AppColors.dark_gray,
            ),
            CustomSettingButton(
                key: impressumKey,
                text: AppLocalizations.of(context).translate(Strings.IMPRESSUM),
                onPressed: _impressumPressed),
            Divider(
              height: Dimens.ONE,
              color: AppColors.dark_gray,
            ),
            CustomSettingButton(
                key: agbKey,
                text: AppLocalizations.of(context).translate(Strings.AGB),
                onPressed: _agbPressed),
            Divider(
              height: Dimens.ONE,
              color: AppColors.dark_gray,
            ),
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

  Widget _logoutButton() {
    return Builder(
      builder: (context) => CustomRaisedButton(
        key: logoutKey,
        text: AppLocalizations.of(context).translate(Strings.LOGOUT),
        backgroundColor: AppColors.dark_gray,
        height: Dimens.FIFTY,
        width: MediaQuery.of(context).size.width,
        borderRadius: Dimens.THIRTY,
        onPressed: _logout,
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
        onPressed: _resetMyProgram,
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
}
