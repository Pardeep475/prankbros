import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/workouts/WorkoutDetails2.dart';
import 'package:prankbros2/popups/CustomChangeWeekDialog.dart';
import 'package:prankbros2/popups/CustomResetRedDialog.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';

class WorkoutDetails extends StatefulWidget {
  WorkoutDetails({this.onPush});

  final ValueChanged<int> onPush;

  @override
  State<StatefulWidget> createState() =>
      _WorkoutDetailsState(onPush: this.onPush);
}

class _WorkoutDetailsState extends State<WorkoutDetails> {
  _WorkoutDetailsState({this.onPush});

  final ValueChanged<int> onPush;

  void _backPressed() {
    print('back button pressed');
    getRootNavigator(context).maybePop();
  }

  NavigatorState getRootNavigator(BuildContext context) {
    final NavigatorState state = Navigator.of(context);
    try {
      print('navigator ' + state.toString());
      return getRootNavigator(state.context);
    } catch (e) {
      print('navigator catch   ' + e.toString());
      return state;
    }
  }

  void _editButtonPressed() {
    showDialog(context: context, builder: (_) => CustomResetRedDialog());
  }

  void _selectWeeksPressed() {
    showDialog(context: context, builder: (_) => CustomChangeWeekDialog());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  AppColors.blueGradientColor,
                  AppColors.pinkGradientColor
                ],
                begin: Alignment.bottomLeft,
              )),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: Dimens.forty,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: _backPressed,
                        splashColor: AppColors.light_gray,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimens.twenty,
                              horizontal: Dimens.fifteen),
                          child: Image.asset(
                            Images.ArrowBackWhite,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      Text(
                        'home Workout'.toUpperCase(),
                        style: TextStyle(
                            color: AppColors.white,
                            fontFamily: Strings.EXO_FONT,
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500),
                      ),
                      InkWell(
                        onTap: _editButtonPressed,
                        splashColor: AppColors.light_gray,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimens.twenty,
                              horizontal: Dimens.fifteen),
                          child: Image.asset(
                            Images.ICON_EDIT,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: Dimens.one,
                    color: AppColors.divider_color,
                  ),
                  SizedBox(
                    height: Dimens.twentySix,
                  ),
                  InkWell(
                    onTap: _selectWeeksPressed,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Week 1',
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: Dimens.twentySeven,
                              fontFamily: Strings.EXO_FONT),
                        ),
                        SizedBox(
                          width: Dimens.twenty,
                        ),
                        Image.asset(
                          Images.ICON_DOWN_ARROW,
                          height: Dimens.sixteen,
                          width: Dimens.sixteen,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimens.forty,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimens.eighty,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  calendarItemUnselected('MO', '01'),
                  calendarItemUnselected('DI', '02'),
                  calendarItemUnselected('MI', '03'),
                  calendarItemSelected('DO', '04'),
                  calendarItemUnselected('FR', '05'),
                  calendarItemUnselected('SA', '06'),
                  calendarItemUnselected('SO', '07'),
                ],
              ),
            ),
            SizedBox(
              height: Dimens.eight,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.twentyFive),
              child: Text(
                'Workouts this week'.toUpperCase(),
                style: TextStyle(
                    color: AppColors.black_text,
                    fontSize: Dimens.eighteen,
                    fontWeight: FontWeight.w600,
                    fontFamily: Strings.EXO_FONT),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.only(top: Dimens.fifteen),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          _mainItemClick(index);
                        },
                        child: mainListItem());
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void _mainItemClick(int index) {
    onPush(index);
//    Navigator.push(
//        context, MaterialPageRoute(builder: (context) => WorkoutDetails2()));
  }

  Widget calendarItemSelected(String day, String date) {
    return Container(
      width: MediaQuery.of(context).size.width/7,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Image.asset(
            Images.ICON_ACTIVE_DAY,
            fit: BoxFit.fitHeight,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.twenty),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  day,
                  style: TextStyle(
                      letterSpacing: 1.43,
                      color: AppColors.white,
                      fontFamily: Strings.EXO_FONT,
                      fontWeight: FontWeight.w500,
                      fontSize: Dimens.eight),
                ),
                SizedBox(
                  height: Dimens.seven,
                ),
                Text(
                  date,
                  style: TextStyle(
                      color: AppColors.white,
                      fontFamily: Strings.EXO_FONT,
                      fontWeight: FontWeight.w700,
                      fontSize: Dimens.thrteen),
                ),
                SizedBox(
                  height: Dimens.seven,
                ),
                Container(
                  height: Dimens.eight,
                  width: Dimens.eight,
                  decoration: BoxDecoration(
                    color: AppColors.pink_stroke,
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimens.twenty)),
                  ),
                ),
                SizedBox(
                  height: Dimens.seventeen,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget calendarItemUnselected(String day, String date) {
    return Container(
      width: MediaQuery.of(context).size.width/7,
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: Dimens.twenty),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            day,
            style: TextStyle(
                letterSpacing: 1.43,
                color: AppColors.calendarWeekNameColor,
                fontFamily: Strings.EXO_FONT,
                fontWeight: FontWeight.w500,
                fontSize: Dimens.eight),
          ),
          SizedBox(
            height: Dimens.seven,
          ),
          Text(
            date,
            style: TextStyle(
                color: AppColors.calendarDateNameColor,
                fontFamily: Strings.EXO_FONT,
                fontWeight: FontWeight.w700,
                fontSize: Dimens.thrteen),
          ),
          SizedBox(
            height: Dimens.seven,
          ),
          Container(
            height: Dimens.eight,
            width: Dimens.eight,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(Dimens.twenty)),
            ),
          ),
          SizedBox(
            height: Dimens.seventeen,
          ),
        ],
      ),
    );
  }

  Widget mainListItem() {
    return Column(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(Dimens.fifteen)),
          ),
          child: Container(
            height: Dimens.oneHundredEightyFive,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(Dimens.fifteen)),
                image: DecorationImage(
                  image: AssetImage(Images.DUMMY_WORKOUT),
                  fit: BoxFit.cover,
                )),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimens.thirty, vertical: Dimens.twentyFive),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'FULL BODY WORKOUT',
                    style: TextStyle(
                        color: AppColors.white,
                        fontFamily: Strings.EXO_FONT,
                        fontStyle: FontStyle.italic,
                        fontSize: Dimens.twentySix,
                        letterSpacing: .75,
                        fontWeight: FontWeight.w900),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              Images.ICON_CALENDAR,
                            ),
                            SizedBox(
                              width: Dimens.seven,
                            ),
                            Text(
                              'Training 1',
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: Dimens.forteen,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: Strings.EXO_FONT),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              Images.ICON_TIMER,
                            ),
                            SizedBox(
                              width: Dimens.seven,
                            ),
                            Text(
                              '30 min',
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: Dimens.forteen,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: Strings.EXO_FONT),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: Dimens.ten,
        ),
      ],
    );
  }
}
