import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/motivation/HistoryWidget.dart';
import 'package:prankbros2/app/dashboard/motivation/MotivationWidget.dart';
import 'package:prankbros2/customviews/BackgroundWidgetWithColor.dart';
import 'package:prankbros2/models/MotivationModel.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';

class Motivation extends StatefulWidget {
  @override
  _MotivationState createState() => _MotivationState();
}

class _MotivationState extends State<Motivation> {
  int _tabClickIndex = 0;
  List<MotivationModel> titleList = new List();
  int _currentTabIndex = 0;


  void _tabClick(int index) {
    setState(() {
      _tabClickIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColors.transparent,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: BackgroundWidgetWithColor(
              curveColor: AppColors.white,
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: Dimens.eighty,
                    left: Dimens.twentyFive,
                    right: Dimens.twentyFive),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text(
                        AppLocalizations.of(context)
                            .translate(Strings.motivation),
                        style: TextStyle(
                            color: AppColors.white,
                            fontFamily: Strings.EXO_FONT,
                            fontWeight: FontWeight.w700,
                            fontSize: Dimens.twentySeven),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _tabClick(0);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: Dimens.twenty),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: _tabClickIndex == 0
                                        ? AppColors.pink_stroke
                                        : AppColors.transparent),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimens.twenty))),
                            padding: EdgeInsets.all(Dimens.ten),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate(Strings.motivation),
                              style: TextStyle(
                                  color: _tabClickIndex == 0
                                      ? AppColors.pink
                                      : AppColors.white,
                                  fontFamily: Strings.EXO_FONT,
                                  fontWeight: FontWeight.w700,
                                  fontSize: Dimens.thrteen),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _tabClick(1);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: Dimens.ten),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: _tabClickIndex == 0
                                        ? AppColors.transparent
                                        : AppColors.pink_stroke),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimens.twenty))),
                            padding: EdgeInsets.all(Dimens.ten),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate(Strings.history),
                              style: TextStyle(
                                  color: _tabClickIndex == 0
                                      ? AppColors.white
                                      : AppColors.pink,
                                  fontFamily: Strings.EXO_FONT,
                                  fontWeight: FontWeight.w700,
                                  fontSize: Dimens.thrteen),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Dimens.thirtyFive,
              ),
              Divider(
                height: Dimens.one,
                color: AppColors.divider_color,
              ),
              SizedBox(
                height: Dimens.thirtyFive,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: Dimens.thirty,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          '3',
                          style: TextStyle(
                              color: AppColors.white,
                              fontFamily: Strings.EXO_FONT,
                              fontWeight: FontWeight.w600,
                              fontSize: Dimens.eighteen),
                        ),
                        SizedBox(
                          height: Dimens.FIVE,
                        ),
                        Text(
                          AppLocalizations.of(context)
                              .translate(Strings.workouts),
                          style: TextStyle(
                              color: AppColors.white,
                              fontFamily: Strings.EXO_FONT,
                              fontWeight: FontWeight.w500,
                              fontSize: Dimens.twelve),
                        ),
                      ],
                    ),
                    Container(
                      color: AppColors.divider_color,
                      height: Dimens.forty,
                      width: Dimens.one,
//                      margin: EdgeInsets.only(top: Dimens.TEN,bottom: Dimens.TEN),
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          '1',
                          style: TextStyle(
                              color: AppColors.white,
                              fontFamily: Strings.EXO_FONT,
                              fontWeight: FontWeight.w600,
                              fontSize: Dimens.eighteen),
                        ),
                        SizedBox(
                          height: Dimens.five,
                        ),
                        Text(
                          AppLocalizations.of(context).translate(Strings.week),
                          style: TextStyle(
                              color: AppColors.white,
                              fontFamily: Strings.EXO_FONT,
                              fontWeight: FontWeight.w500,
                              fontSize: Dimens.twelve),
                        ),
                      ],
                    ),
                    Container(
                      color: AppColors.divider_color,
                      height: Dimens.forty,
                      width: Dimens.one,
//                      margin: EdgeInsets.only(top: Dimens.TEN,bottom: Dimens.TEN),
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          '1/4',
                          style: TextStyle(
                              color: AppColors.white,
                              fontFamily: Strings.EXO_FONT,
                              fontWeight: FontWeight.w600,
                              fontSize: Dimens.eighteen),
                        ),
                        SizedBox(
                          height: Dimens.five,
                        ),
                        Text(
                          AppLocalizations.of(context)
                              .translate(Strings.motivation),
                          style: TextStyle(
                              color: AppColors.white,
                              fontFamily: Strings.EXO_FONT,
                              fontWeight: FontWeight.w500,
                              fontSize: Dimens.twelve),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _tabClickIndex == 0
                    ? MotivationWidget()
                    : HistoryWidget(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
