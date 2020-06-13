import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  }

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

  Widget _tabBarViewWidget() {
    return Expanded(
      child: TabBarView(
        children: <Widget>[
          ProfileWidget(),
          PictureWidget(),
          WeightCurveWidget(),
          SettingsWidget(),
        ],
      ),
    );
  }

}
