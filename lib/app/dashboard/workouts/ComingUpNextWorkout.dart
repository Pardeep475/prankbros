import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/workouts/WarmUpScreen.dart';
import 'package:prankbros2/commonwidgets/ease_in_widget.dart';
import 'package:prankbros2/models/workout/GetUserTrainingResponseApi.dart';
import 'package:prankbros2/models/workout/WorkoutDetail2Models.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Utils.dart';

class ComingUpNextWorkout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ComingUpNextWorkoutState();
}

class _ComingUpNextWorkoutState extends State<ComingUpNextWorkout> {
  WorkoutDetail2Models _workoutDetail2Models;
  String _baseUrl = "";
  List<Exercises> _exercisesList = new List();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _workoutDetail2Models = ModalRoute.of(context).settings.arguments;

    try {
      if (_workoutDetail2Models != null &&
          _workoutDetail2Models.trainings != null &&
          _workoutDetail2Models.trainings.exercises != null &&
          _workoutDetail2Models.trainings.exercises.length > 0)
        _exercisesList.addAll(_workoutDetail2Models.trainings.exercises);
      _baseUrl = _workoutDetail2Models.baseUrl;
    } catch (e) {
      debugPrint('${e.toString()}');
    }

//    _workoutListInit();
  }

  @override
  Widget build(BuildContext context) {
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
              _exercisesList.length > 0 &&
                      _exercisesList[0].exerciseTime != null
                  ? _exercisesList[0].exerciseTime
                  : "",
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
              _exercisesList.length > 0 && _exercisesList[0].nameEN != null
                  ? _exercisesList[0].nameEN
                  : "",
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
                EaseInWidget(
                  onTap: _openWorkoutDetailStepByStep,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimens.fifteen)),
                    child:
                        /*Image.asset(
                      Images.DUMMY_WORKOUT,
                      fit: BoxFit.cover,
                      height: Dimens.oneHundredFiftyTwo,
                      width: Dimens.twoHundredNinetyFive,
                    ),*/
                        CachedNetworkImage(
                      height: Dimens.oneHundredFiftyTwo,
                      width: Dimens.twoHundredNinetyFive,
                      imageUrl: _exercisesList.length > 0 &&
                              _exercisesList[0].imagePath != null
                          ? '$_baseUrl${_exercisesList[0].imagePath}'
                          : "",
                      imageBuilder: (context, imageProvider) => Container(
                        height: Dimens.oneHundredFiftyTwo,
                        width: Dimens.twoHundredNinetyFive,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) =>
                          Utils.getImagePlaceHolderWidgetProfile(
                        context: context,
                        img: Images.DUMMY_WORKOUT,
                        height: Dimens.oneHundredFiftyTwo,
                        width: Dimens.twoHundredNinetyFive,
                      ),
                      errorWidget: (context, url, error) =>
                          Utils.getImagePlaceHolderWidgetProfile(
                        context: context,
                        img: Images.DUMMY_WORKOUT,
                        height: Dimens.oneHundredFiftyTwo,
                        width: Dimens.twoHundredNinetyFive,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: _openWorkoutDetailStepByStep,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: Dimens.twenty,
                        left: Dimens.twenty,
                        right: Dimens.twentyFive,
                        bottom: Dimens.thirtyFive),
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
            ),
          ],
        ),
      ),
    );
  }

  void _openWorkoutDetailStepByStep() async{
    var pushed= await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WarmUpScreen(
                  workoutDetail2Models: _workoutDetail2Models,
                )));
    if(pushed){
      Navigator.pop(context);
    }
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
