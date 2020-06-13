import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/workouts/ComingUpNextWorkout.dart';
import 'package:prankbros2/customviews/BackgroundWidgetWithImage.dart';
import 'package:prankbros2/customviews/CustomViews.dart';
import 'package:prankbros2/models/DailyWorkoutModel.dart';
import 'package:prankbros2/models/WorkoutDetails2Model.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Keys.dart';
import 'package:prankbros2/utils/Strings.dart';

class WorkoutDetails2 extends StatefulWidget {
  WorkoutDetails2({this.onPush});

  final ValueChanged<int> onPush;

  @override
  State<StatefulWidget> createState() =>
      _WorkoutDetails2State(onPush: this.onPush);
}

class _WorkoutDetails2State extends State<WorkoutDetails2> {
  List<WorkoutDetails2Model> _workoutList = new List();

  _WorkoutDetails2State({this.onPush});

  final ValueChanged<int> onPush;

  static const Key downloadWorkoutButtonKey =
      Key(Keys.downloadWorkoutButtonKey);
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _workoutListInit();
  }

  void _workoutListInit() {
    List<DailyWorkoutModel> warmUpList = new List();
    List<DailyWorkoutModel> workoutList = new List();

    warmUpList.add(
      DailyWorkoutModel(
          mainTitle: 'warm up',
          title: 'Crosstrainer',
          timing: '15 Minuten',
          imgUrl: Images.DummyFood,
          rest: ''),
    );

    workoutList.add(
      DailyWorkoutModel(
          mainTitle: 'Hauptprogramm',
          title: 'Beinpresse',
          timing: '12-15 Wdh.',
          imgUrl: Images.DummyFood,
          rest: '10 second rest'),
    );

    workoutList.add(
      DailyWorkoutModel(
          mainTitle: '',
          title: 'Rückenpresse',
          timing: '12-15 Wdh.',
          imgUrl: Images.DummyFood,
          rest: 'no rest'),
    );

    workoutList.add(
      DailyWorkoutModel(
          mainTitle: '',
          title: 'Superman',
          timing: '12-15 Wdh.',
          imgUrl: Images.DummyFood,
          rest: ''),
    );

    _workoutList.add(
        WorkoutDetails2Model(warmUpList: warmUpList, workoutList: workoutList));

    for (int i = 0; i < _workoutList[0].workoutList.length; i++) {
      debugPrint(
          'workoutlist :  ${_workoutList[0].workoutList[i].title} ');
    }
    for (int i = 0; i < _workoutList[0].warmUpList.length; i++) {
      debugPrint(
          'warmuplist :  ${_workoutList[0].warmUpList[i].title}');
    }
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

  Widget _WorkoutDetails2Widget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: Dimens.forty,
        ),
        GestureDetector(
          onTap: () {
            getRootNavigator(context).maybePop();
          },
          child: Container(
            margin: EdgeInsets.only(left: Dimens.fifteen),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(Dimens.ninety)),
            ),
            child: Image.asset(
              Images.ArrowBackWhite,
              color: AppColors.black,
              fit: BoxFit.none,
              width: Dimens.forty,
              height: Dimens.forty,
            ),
          ),
        ),
        SizedBox(
          height: Dimens.sixty,
        ),
        Padding(
          padding: EdgeInsets.only(left: Dimens.thirtyFive),
          child: Text(
            'Full Body',
            style: TextStyle(
                fontSize: Dimens.thirty,
                fontWeight: FontWeight.w900,
                color: AppColors.white,
                letterSpacing: 0.75,
                fontFamily: Strings.EXO_FONT,
                fontStyle: FontStyle.italic),
          ),
        ),
        SizedBox(
          height: Dimens.fifteen,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimens.thirtyFive),
          padding: EdgeInsets.symmetric(vertical: Dimens.ten),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(Dimens.ninety)),
            gradient: LinearGradient(
              colors: [AppColors.pink, AppColors.blue],
              begin: Alignment.bottomLeft,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: Dimens.fifteen,
              ),
              Image.asset(Images.ICON_TIMER),
              SizedBox(
                width: Dimens.ten,
              ),
              Wrap(
                children: <Widget>[
                  Text(
                    '30 min',
                    style: TextStyle(
                      fontSize: Dimens.forteen,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                      fontFamily: Strings.EXO_FONT,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: Dimens.fifteen,
              ),
            ],
          ),
        ),
        SizedBox(
          height: Dimens.fiftyFive,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.thirtyFive),
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
            style: TextStyle(
              fontSize: Dimens.fifteen,
              fontWeight: FontWeight.w500,
              color: AppColors.light_text,
              fontFamily: Strings.EXO_FONT,
            ),
          ),
        ),
        SizedBox(
          height: Dimens.thirtyTwo,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.thirtyFive),
          child: _downloadButton(),
        ),
        SizedBox(
          height: Dimens.twenty,
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: Dimens.fifteen),
            child: Card(
              elevation: 5,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(Dimens.ten)),
              ),
              child: CustomScrollView(
                slivers: <Widget>[
                  // warm up list
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {

                      return _mainItemBuilder(
                          context,
                          index,
                          _workoutList[0].warmUpList[index],
                          _workoutList[0].warmUpList.length);
                    }, childCount: _workoutList[0].warmUpList.length),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(top: Dimens.twenty),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return _mainItemBuilder(
                          context,
                          index,
                          _workoutList[0].workoutList[index],
                          _workoutList[0].workoutList.length);
                    }, childCount: _workoutList[0].workoutList.length),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _mainItemClick() {
    onPush(0);
//    Navigator.push(
//        context, MaterialPageRoute(builder: (context) => ComingUp()));
  }

  Widget _mainItemBuilder(BuildContext context, int index,
      DailyWorkoutModel dailyWorkoutModel, int size) {
    debugPrint(
        'index--:  $index   title--:   ${dailyWorkoutModel.rest}  size--:  $size');
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: _mainItemClick,
        child: Container(
          margin: EdgeInsets.only(
              left: Dimens.twenty,
              top: Dimens.twenty,
              bottom: size - 1 == index ? Dimens.seventeen : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                child: dailyWorkoutModel.mainTitle =='' ? Text(
                  dailyWorkoutModel.mainTitle.toUpperCase(),
                  style: TextStyle(
                      letterSpacing: 1.04,
                      fontWeight: FontWeight.w600,
                      fontSize: Dimens.fifteen,
                      color: AppColors.unSelectedTextRadioColor,
                      fontFamily: Strings.EXO_FONT),
                ) :SizedBox(height: 0,) ,
              ),
              SizedBox(
                height: Dimens.eight,
              ),
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimens.eight)),
                    child: Image.asset(
                      Images.DummyFood,
                      height: Dimens.eighty,
                      width: Dimens.eighty,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: Dimens.fifteen,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        dailyWorkoutModel.title,
                        style: TextStyle(
                            letterSpacing: 1.04,
                            fontWeight: FontWeight.w600,
                            fontSize: Dimens.twenty,
                            color: AppColors.black_text,
                            fontFamily: Strings.EXO_FONT),
                      ),
                      SizedBox(
                        height: Dimens.ten,
                      ),
                      Text(
                        dailyWorkoutModel.timing,
                        style: TextStyle(
                            letterSpacing: 1.04,
                            fontWeight: FontWeight.w500,
                            fontSize: Dimens.fifteen,
                            color: AppColors.light_text,
                            fontFamily: Strings.EXO_FONT),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                child: size - 1 != index
                    ? Row(
                        children: <Widget>[
                          Expanded(
                            child: Divider(
                              height: Dimens.one,
                              color: AppColors.divider_color_2,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimens.twenty)),
                                border: Border.all(
                                    color: AppColors.divider_color_2,
                                    width: Dimens.one)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimens.twenty,
                                  vertical: Dimens.eight),
                              child: Text(
                                dailyWorkoutModel.rest,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: Dimens.forteen,
                                    letterSpacing: 1.04,
                                    fontFamily: Strings.EXO_FONT,
                                    color: AppColors.unSelectedTextRadioColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Dimens.twentyFive,
                            child: Divider(
                              height: Dimens.one,
                              color: AppColors.divider_color_2,
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        height: 0,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _downloadButton() {
    return Builder(
      builder: (context) => CustomRaisedButton(
        key: downloadWorkoutButtonKey,
        text: 'Download & start workout'.toUpperCase(),
        backgroundColor: AppColors.pink_stroke,
        height: Dimens.sixty,
        width: MediaQuery.of(context).size.width,
        borderRadius: Dimens.thirty,
        onPressed: () {
          _downloadButtonPressed(context);
        },
        isGradient: true,
        loading: _isLoading,
        textStyle: TextStyle(
          fontSize: Dimens.fifteen,
          letterSpacing: 1.12,
          color: AppColors.white,
          fontWeight: FontWeight.w700,
          fontFamily: Strings.EXO_FONT,
        ),
      ),
    );
  }

  void _downloadButtonPressed(BuildContext context) {
    setState(() {
      _isLoading = _isLoading ? false : true;
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ComingUpNextWorkout()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        BackgroundWidgetWithImage(
          imagePath: Images.ICON_WORKOUT_HALF,
          curveColor: AppColors.workoutDetail2BackColor,
        ),
        Scaffold(
          backgroundColor: AppColors.transparent,
          body: _WorkoutDetails2Widget(),
        ),
      ],
    );
  }
}
