import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/workouts/WorkoutDetails.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';

class Workouts extends StatelessWidget {
  Workouts({this.onPush});

  final ValueChanged<String> onPush;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Dimens.eighty),
        child: Container(
          color: AppColors.white,
          padding: EdgeInsets.only(bottom: Dimens.fifteen),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              AppLocalizations.of(context).translate(Strings.workouts),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: Dimens.twentySeven,
                  fontWeight: FontWeight.w700,
                  fontFamily: Strings.EXO_FONT,
                  color: AppColors.black_text),
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.WORKOUTS_BACKGROUND),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: Dimens.fifty,
            top: Dimens.twoHundredFive,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'HOME',
                  style: TextStyle(
                      letterSpacing: 3.2,
                      color: AppColors.white,
                      fontSize: Dimens.forty,
                      fontStyle: FontStyle.italic,
                      fontFamily: Strings.EXO_FONT,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: Dimens.TEN,
                ),
                Text(
                  'Workout',
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: Dimens.eighteen,
                      fontFamily: Strings.EXO_FONT,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Positioned(
            right: Dimens.fifty,
            bottom: Dimens.oneHundredFifty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'GYM',
                  style: TextStyle(
                      letterSpacing: 3.2,
                      color: AppColors.white,
                      fontSize: Dimens.forty,
                      fontStyle: FontStyle.italic,
                      fontFamily: Strings.EXO_FONT,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: Dimens.ten,
                ),
                Text(
                  'Workout',
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: Dimens.eighteen,
                      fontFamily: Strings.EXO_FONT,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: Dimens.hundred,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _homeWorkoutClick(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _gymWorkoutClick(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                  ),
                ),
              ),
              SizedBox(
                height: Dimens.seventy,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _homeWorkoutClick(BuildContext context) {
    onPush('Home');
//    Navigator.push(
//        context, MaterialPageRoute(builder: (context) => WorkoutDetails()));
  }

  void _gymWorkoutClick(BuildContext context) {
    onPush('gym');
  }
}
