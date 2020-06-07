import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              height: 56,
            ),
            Text(
              'REST',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3.44,
                  fontSize: Dimens.EIGHTY_SIX,
                  color: AppColors.black_text,
                  fontFamily: Strings.EXO_FONT),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '00:56',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: Dimens.FIFTY_SIX,
                  letterSpacing: 2.24,
                  color: AppColors.black_text,
                  fontFamily: Strings.EXO_FONT),
            ),
            SizedBox(
              height: 214,
            ),
            Text(
              'Upright cable row',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.black_text,
                  fontSize: Dimens.TWENTY_SIX,
                  fontFamily: Strings.EXO_FONT),
            ),
            SizedBox(
              height: 16,
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
                  width: 15,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  elevation: 10,
                  child: Image.asset(
                    Images.COMING_UP_NEXT_WORKOUT_BACKGROUND,
                    height: 152,
                    width: 295,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.only(top: 20, left: 20, right: 25, bottom: 35),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'SKIP',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        fontSize: Dimens.FORTEEN,
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
                fontSize: Dimens.THRTEEN,
                fontFamily: Strings.EXO_FONT,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w700,
                color: AppColors.pink_stroke),
          )));
    }
    return res;
  }
}
