import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/workouts/WarmUpScreen.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';

class ComingUpNextWorkout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ComingUpNextWorkoutState();
}

class _ComingUpNextWorkoutState extends State<ComingUpNextWorkout> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Images.COMING_UP_NEXT_WORKOUT_BACKGROUND),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: Dimens.fiftySix,
            ),
            Text(
              'REST',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3.44,
                  fontSize: Dimens.eightySex,
                  color: AppColors.black_text,
                  fontFamily: Strings.EXO_FONT),
            ),
            SizedBox(
              height: Dimens.twenty,
            ),
            Text(
              '00:56',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: Dimens.fiftySix,
                  letterSpacing: 2.24,
                  color: AppColors.black_text,
                  fontFamily: Strings.EXO_FONT),
            ),
            SizedBox(
              height: Dimens.twoHundredForteen,
            ),
            Text(
              'Upright cable row',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.black_text,
                  fontSize: Dimens.twentySix,
                  fontFamily: Strings.EXO_FONT),
            ),
            SizedBox(
              height: Dimens.sixteen,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Wrap(
                  direction: Axis.vertical,
                  children: _getWords(),
                ),
                SizedBox(
                  width: Dimens.fifteen,
                ),
                GestureDetector(
                  onTap: _openWorkoutDetailStepByStep,
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.fifteen)),
                    ),
                    elevation: Dimens.ten,
                    child: Image.asset(
                      Images.DUMMY_WORKOUT,
                      fit: BoxFit.cover,
                      height: Dimens.oneHundredFiftyTwo,
                      width: Dimens.twoHundredNinetyFive,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    top: Dimens.twenty,
                    left: Dimens.twenty,
                    right: Dimens.twentyFive,
                    bottom: Dimens.thirtyFive),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'SKIP',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        fontSize: Dimens.forteen,
                        letterSpacing: 1.12,
                        fontFamily: Strings.EXO_FONT),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openWorkoutDetailStepByStep() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WarmUpScreen()));
//    Navigator.pushNamed(context, Strings.WARM_UP_ROUTE);
  }

  List<Widget> _getWords() {
    const text = "UP COMING";
    List<Widget> res = [];
    var words = text.split(" ");
    for (var word in words) {
      res.add(RotatedBox(
          quarterTurns: 3,
          child: Text(
            word + ' ',
            style: TextStyle(
                fontSize: Dimens.thrteen,
                fontFamily: Strings.EXO_FONT,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w700,
                color: AppColors.pink_stroke),
          )));
    }
    return res;
  }
}
