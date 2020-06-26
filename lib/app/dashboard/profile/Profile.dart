import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prankbros2/app/dashboard/profile/PictureWidget.dart';
import 'package:prankbros2/app/dashboard/profile/ProfileWidget.dart';
import 'package:prankbros2/app/dashboard/profile/SettingsWidget.dart';
import 'package:prankbros2/customviews/BackgroundWidgetWithColor.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';

import 'WeightCurveWidget.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  int itemPos = 0;
  List<String> _titleList = new List();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _titleListInit();
  }

  void _titleListInit() {
    _titleList.add(AppLocalizations.of(context).translate(Strings.Profile));
    _titleList.add(AppLocalizations.of(context).translate(Strings.Pictures));
    _titleList.add(AppLocalizations.of(context).translate(Strings.WeightCurve));
    _titleList.add(AppLocalizations.of(context).translate(Strings.Settings));
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ));

    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.TopBg),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Scaffold(
          resizeToAvoidBottomPadding: false,
          resizeToAvoidBottomInset : false,
          backgroundColor: AppColors.transparent,
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Dimens.FORTY),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: Dimens.seventyFive,
                  ),
                  _topUserProfile(),
                  SizedBox(
                    height: Dimens.thirty,
                  ),
                  Divider(
                    height: Dimens.one,
                    color: AppColors.divider_color,
                  ),
                  SizedBox(
                    height: Dimens.twentyFive,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: Dimens.fifty,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                        itemCount: _titleList.length,
                        itemBuilder: (BuildContext conntext, int pos) {
                          return _customTextWidget(_titleList[pos], pos);
                        }),
                  ),
                  SizedBox(
                      height: 500,
                      width: MediaQuery.of(context).size.width,
                      child: openSpecificTab(itemPos)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget openSpecificTab(int pos) {
    switch (pos) {
      case 0:
        {
          return ProfileWidget();
        }
        break;
      case 1:
        {
          return PictureWidget();
        }
        break;
      case 2:
        {
          return WeightCurveWidget();
        }
        break;
      case 3:
        {
          return SettingsWidget();
        }
        break;
      default:
        {
          return ProfileWidget();
        }
        break;
    }
  }

  /*
  *
  * return Scaffold(
      backgroundColor: AppColors.transparent,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: BackgroundWidgetWithColor(
              curveColor: AppColors.workoutDetail2BackColor,
            ),
          ),
          DefaultTabController(
            length: 4, // Added
            initialIndex: 0,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: Dimens.seventyFive,
                ),
                _topUserProfile(),
                SizedBox(
                  height: Dimens.thirty,
                ),
                Divider(
                  height: Dimens.one,
                  color: AppColors.divider_color,
                ),
                SizedBox(
                  height: Dimens.twentyFive,
                ),
                _tabBarWidget(),
                _tabBarViewWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  * */

  Widget _topUserProfile() {
    return Row(
      children: <Widget>[
        Container(
            margin:
                EdgeInsets.only(left: Dimens.TWENTY_FIVE, right: Dimens.TWENTY),
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
    );
  }

  Widget _customTextWidget(String title, int pos) {
    return GestureDetector(
      onTap: () {
        setState(() {
          itemPos = pos;
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: Dimens.twenty),
        width: MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
            border: Border.all(
                color: itemPos == pos
                    ? AppColors.pink_stroke
                    : AppColors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(Dimens.twenty))),
        padding: EdgeInsets.symmetric(vertical: Dimens.ten),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: itemPos == pos ? AppColors.pink : AppColors.white,
              fontFamily: Strings.EXO_FONT,
              fontWeight: FontWeight.w700,
              fontSize: Dimens.thrteen),
        ),
      ),
    );
  }

  Widget _tabBarWidget() {
    return TabBar(
      isScrollable: true,
      unselectedLabelColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppColors.pink,
      indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.FIFTY),
          border: Border.all(color: AppColors.pink_stroke, width: Dimens.ONE)),
      tabs: <Widget>[
        Tab(
          child: Align(
            alignment: Alignment.center,
            child:
                Text(AppLocalizations.of(context).translate(Strings.Profile)),
          ),
        ),
        Tab(
          child: Align(
            alignment: Alignment.center,
            child:
                Text(AppLocalizations.of(context).translate(Strings.Pictures)),
          ),
        ),
        Tab(
          child: Align(
            alignment: Alignment.center,
            child: Text(
                AppLocalizations.of(context).translate(Strings.WeightCurve)),
          ),
        ),
        Tab(
          child: Align(
            alignment: Alignment.center,
            child:
                Text(AppLocalizations.of(context).translate(Strings.Settings)),
          ),
        ),
      ],
    );
  }
}
