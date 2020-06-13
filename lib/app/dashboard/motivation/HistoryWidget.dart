import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/models/MotivationHistoryModel.dart';
import 'package:prankbros2/popups/CustomChangeWeekDialog.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';

class HistoryWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  List<MotivationHistoryItem> _motivationHistoryList = new List();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _motivationHistoryListInit();
  }

  void _motivationHistoryListInit() {
    _motivationHistoryList.add(MotivationHistoryItem(
        date: '01', weekDay: 'MO', title: '', isSelected: false));
    _motivationHistoryList.add(MotivationHistoryItem(
        date: '02', weekDay: 'DI', title: '', isSelected: false));
    _motivationHistoryList.add(MotivationHistoryItem(
        date: '03', weekDay: 'MI', title: 'Abs & Arms', isSelected: true));
    _motivationHistoryList.add(MotivationHistoryItem(
        date: '04', weekDay: 'DO', title: '', isSelected: false));
    _motivationHistoryList.add(MotivationHistoryItem(
        date: '05', weekDay: 'FR', title: '', isSelected: false));
    _motivationHistoryList.add(MotivationHistoryItem(
        date: '06', weekDay: 'SA', title: '', isSelected: false));
    _motivationHistoryList.add(MotivationHistoryItem(
        date: '07', weekDay: 'SO', title: '', isSelected: false));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _historyWidget();
  }

  Widget _historyWidget() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.only(top: Dimens.sixty),
        ),
        SliverToBoxAdapter(
          child: _headerWidget(),
        ),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            if (_motivationHistoryList[index].isSelected) {
              return _selectedListItem(_motivationHistoryList[index], index);
            } else {
              return _unSelectedListItem(_motivationHistoryList[index], index);
            }
          }, childCount: _motivationHistoryList.length),
        ),
      ],
    );
  }

  Widget _headerWidget() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: Dimens.thirty,
            ),
            Image.asset(
              Images.ICON_DUMBBELL_INACTIVE,
              height: Dimens.fortyFive,
              width: Dimens.fortyFive,
              color: AppColors.light_text,
            ),
            SizedBox(
              width: Dimens.twenty,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Workout activity',
                    style: TextStyle(
                        fontSize: Dimens.twenty,
                        fontFamily: Strings.EXO_FONT,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black_text),
                  ),
                  SizedBox(
                    height: Dimens.eight,
                  ),
                  Material(
                    color: AppColors.transparent,
                    child: InkWell(
                      onTap: () {
                        _openChangeWeekDialog();
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            '01-07 aug 2019',
                            style: TextStyle(
                                fontSize: Dimens.sixteen,
                                fontFamily: Strings.EXO_FONT,
                                fontWeight: FontWeight.w500,
                                color: AppColors.light_text),
                          ),
                          SizedBox(
                            width: Dimens.fifteen,
                          ),
                          Image.asset(Images.ICON_DOWN_ARROW,height: Dimens.sixteen,width: Dimens.sixteen,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Dimens.thirty,
            ),
          ],
        ),
        SizedBox(
          height: Dimens.twenty,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.twentyFive),
          child: Divider(
            color: AppColors.divider_color,
            height: Dimens.one,
          ),
        ),
      ],
    );
  }

  void _openChangeWeekDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => CustomChangeWeekDialog());
  }

  Widget _selectedListItem(
      MotivationHistoryItem motivationHistoryItem, int index) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimens.ONE_ONE_SEVEN),
                      bottomRight: Radius.circular(Dimens.ONE_ONE_SEVEN)),
                  gradient: LinearGradient(
                    colors: [AppColors.blue, AppColors.pink],
                    begin: Alignment.bottomLeft,
                  )),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: Dimens.thirtySix,
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: Dimens.fifteen,
                      ),
                      Text(
                        motivationHistoryItem.date,
                        style: TextStyle(
                            fontSize: Dimens.twenty,
                            fontFamily: Strings.EXO_FONT,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white),
                      ),
                      SizedBox(
                        height: Dimens.five,
                      ),
                      Text(
                        motivationHistoryItem.weekDay,
                        style: TextStyle(
                            fontSize: Dimens.twelve,
                            fontFamily: Strings.EXO_FONT,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.79,
                            color: AppColors.white),
                      ),
                      SizedBox(
                        height: Dimens.fifteen,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: Dimens.fifteen,
                  ),
                  Container(
                    height: Dimens.eight,
                    width: Dimens.eight,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(Dimens.twenty),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Dimens.twentyFive,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Dimens.thrteen,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimens.twentyFive, vertical: Dimens.fifteen),
                decoration: BoxDecoration(
                  color: AppColors.light_gray,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimens.hundred)),
                ),
                child: Text(
                  motivationHistoryItem.title,
                  style: TextStyle(
                      fontSize: Dimens.eighteen,
                      fontFamily: Strings.EXO_FONT,
                      fontWeight: FontWeight.w700,
                      color: AppColors.light_text),
                ),
              ),
            ),
            SizedBox(
              width: Dimens.thirtySix,
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.twentyFive),
          child: Divider(
            color: index == _motivationHistoryList.length - 1
                ? AppColors.white
                : AppColors.divider_color,
            height: Dimens.one,
          ),
        ),
      ],
    );
  }

  Widget _unSelectedListItem(
      MotivationHistoryItem motivationHistoryItem, int index) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: Dimens.thirtySix,
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: Dimens.fifteen,
                    ),
                    Text(
                      motivationHistoryItem.date,
                      style: TextStyle(
                          fontSize: Dimens.twenty,
                          fontFamily: Strings.EXO_FONT,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black_text),
                    ),
                    SizedBox(
                      height: Dimens.five,
                    ),
                    Text(
                      motivationHistoryItem.weekDay,
                      style: TextStyle(
                          fontSize: Dimens.twelve,
                          fontFamily: Strings.EXO_FONT,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.79,
                          color: AppColors.unSelectedTextRadioColor),
                    ),
                    SizedBox(
                      height: Dimens.fifteen,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.twentyFive),
          child: Divider(
            color: index == _motivationHistoryList.length - 1
                ? AppColors.white
                : AppColors.divider_color,
            height: Dimens.one,
          ),
        ),
      ],
    );
  }
}
