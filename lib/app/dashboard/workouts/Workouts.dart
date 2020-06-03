import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/workouts/WorkoutDetails.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';

class Workouts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          AppLocalizations.of(context).translate(Strings.workouts),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 27, color: AppColors.black_text),
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
            left: 50,
            top: 205,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'HOME',
                  style: TextStyle(
                      letterSpacing: 3.2,
                      color: AppColors.white,
                      fontSize: Dimens.FORTY,
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
                      fontSize: Dimens.EIGHTEEN,
                      fontFamily: Strings.EXO_FONT,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Positioned(
            right: 50,
            bottom: 145,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'GYM',
                  style: TextStyle(
                      letterSpacing: 3.2,
                      color: AppColors.white,
                      fontSize: Dimens.FORTY,
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
                      fontSize: Dimens.EIGHTEEN,
                      fontFamily: Strings.EXO_FONT,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: Dimens.HUNDRUD,
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
                height: Dimens.SEVENTY,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _homeWorkoutClick(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('top')));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WorkoutDetails()));
  }

  void _gymWorkoutClick(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('bottom')));
  }
}
