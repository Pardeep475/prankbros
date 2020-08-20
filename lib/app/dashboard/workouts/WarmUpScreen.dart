import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/videoplayer/VideoScreenBloc.dart';
import 'package:prankbros2/app/dashboard/workouts/WarmUpCompleted.dart';
import 'package:prankbros2/app/dashboard/workouts/WorkOutCompleted.dart';
import 'package:prankbros2/models/workout/GetUserTrainingResponseApi.dart';
import 'package:prankbros2/models/workout/WorkoutDetail2Models.dart';
import 'package:prankbros2/popups/CustomListPopUp.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:video_player/video_player.dart';

class WarmUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WarmUpScreenState();
}

class _WarmUpScreenState extends State<WarmUpScreen> {
  List<String> _contentList = new List<String>();

  TextEditingController _textEditingController;

  WorkoutDetail2Models _workoutDetail2Models;
  String _baseUrl = "";
  List<Exercises> _exercisesList = new List();

  VideoPlayerController _videoPlayerController;
  bool startedPlaying = false;
  VideoScreenBloc _videoScreenBloc;

  Timer _timer;
  int _start = 0;
  int _timing = 0;

  @override
  void initState() {
    super.initState();
    _textEditingController = new TextEditingController();
    _videoScreenBloc = new VideoScreenBloc();
    _contentListInit();
  }

  void _contentListInit() {
    for (int i = 0; i < 4; i++) {
      _contentList.add(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _workoutDetail2Models = ModalRoute
        .of(context)
        .settings
        .arguments;

    try {
      if (_workoutDetail2Models != null &&
          _workoutDetail2Models.trainings != null &&
          _workoutDetail2Models.trainings.exercises != null &&
          _workoutDetail2Models.trainings.exercises.length > 0)
        _exercisesList.addAll(_workoutDetail2Models.trainings.exercises);
      _baseUrl = _workoutDetail2Models.baseUrl;
//      _timing= parseDuration(_exercisesList[0].exerciseTime);

      _videoPlayerController = VideoPlayerController.network(
          '$_baseUrl${_exercisesList[0].videoPath}');
      _videoPlayerController.addListener(() {
//      if (startedPlaying && !_videoPlayerController.value.isPlaying) {
//        Navigator.pop(context);
//      }
      });
    } catch (e) {
      debugPrint('${e.toString()}');
    }

//    _workoutListInit();
  }

  @override
  void dispose() {
    if (_timer != null) _timer.cancel();
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<bool> started() async {
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.initialize();
    debugPrint('started----------------');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height / 1.4,
            child: Material(
              elevation: 0,
              child: Center(
                child: FutureBuilder<bool>(
                  future: started(),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.data == true) {
                      return Stack(
                        children: <Widget>[
                          VideoPlayer(_videoPlayerController),
                          _PlayPauseOverlay(
                            controller: _videoPlayerController,
                            videoScreenBloc: _videoScreenBloc,
                          ),
                        ],
                      );
                    } else {
                      return const Text('waiting for video to load');
                    }
                  },
                ),
              ),
            ),
          ),
//          Image.asset(
//            Images.GYM_WORK_BACKGROUND,
//            height: MediaQuery.of(context).size.height/1.4,
//            width: MediaQuery.of(context).size.width,
//            fit: BoxFit.cover,
//          ),
          Positioned(
            top: 35,
            left: 1,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: Dimens.FORTY_FIVE,
                height: Dimens.FORTY_FIVE,
                margin: EdgeInsets.only(top: Dimens.twenty, left: Dimens.ten),
                child: Container(
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                    borderRadius:
                    BorderRadius.all(Radius.circular(Dimens.THIRTY)),
                  ),
                  child: Center(
                      child: Image.asset(Images.ArrowBackWhite,
                          height: Dimens.fifteen,
                          width: Dimens.twenty,
                          color: AppColors.white)),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Wrap(
              children: <Widget>[
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.pink, AppColors.blue],
                        begin: Alignment.bottomLeft,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () =>
                              showDialog(
                                  context: context,
                                  builder: (_) =>
                                      CustomListPopUp(
                                        contentList: _contentList,
                                      )),
                          child: Padding(
                              padding: EdgeInsets.only(right: 37),
                              child: Image.asset(Images.ICON_HELP)),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: _completedDetectClick,
                        child: Text(
                          'Upright cable row',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: Strings.EXO_FONT,
                              color: AppColors.white,
                              fontSize: Dimens.TWENTY_SIX),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Warm-Up',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: Strings.EXO_FONT,
                            color: AppColors.white,
                            fontSize: Dimens.THRTEEN),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          height: 1,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        '$_start',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: Strings.EXO_FONT,
                            color: AppColors.white,
                            fontSize: Dimens.TWENTY_SIX),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          _playVideo();
                        },
                        child: Image.asset(
                          Images.ICON_PLAY,
                          height: 57,
                          width: 57,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _completedDetectClick() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WarmUpCompleted()));
  }

  void _playVideo() async {
    String valueString = parseDurationString(_exercisesList[0].exerciseTime);
    int valueInt = parseDurationInt(_exercisesList[0].exerciseTime);
    _timing = valueInt;
    debugPrint('timing -- $valueString    $valueInt');

    if (!startedPlaying) {
      await _videoPlayerController.play();
      startedPlaying = true;
      startTimer();
    }
  }

  String parseDurationString(String s) {
    String hours = "00";
    String minutes = "00";
    String seconds = "00";

    try {
      List<String> parts = s.split(':');
      if (parts.length > 2) {
        hours = parts[parts.length - 3].length > 1
            ? parts[parts.length - 3]
            : '0${parts[parts.length - 3]}';
      }
      if (parts.length > 1) {
        minutes = parts[parts.length - 2].length > 1
            ? parts[parts.length - 2]
            : '0${parts[parts.length - 2]}';
      }
      seconds = parts[parts.length - 1].length > 0
          ? parts[parts.length - 1]
          : '0${parts[parts.length - 1]}';
      debugPrint("hours   $hours  minutes   $minutes   seconds  $seconds");

      return '$hours:$minutes:$seconds';
    } catch (e) {
      return "00:00:00";
    }
  }

  int parseDurationInt(String s) {
    int hours = 0;
    int minutes = 0;
    int seconds;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    seconds = int.parse(parts[parts.length - 1]);
    debugPrint("hours   $hours  minutes   $minutes   seconds  $seconds");
    debugPrint(
        "seconds ${Duration(hours: hours, minutes: minutes, seconds: seconds)
            .inSeconds}");
    return Duration(hours: hours, minutes: minutes, seconds: seconds).inSeconds;
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) =>
          setState(
                () {
              if (_start == _timing) {
                timer.cancel();
              } else {
                _start = _start + 1;
                _textEditingController.text = Duration(seconds: _start).toString();
              }
            },
          ),
    );
  }
}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({Key key, this.controller, this.videoScreenBloc})
      : super(key: key);

  final VideoPlayerController controller;
  final VideoScreenBloc videoScreenBloc;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: StreamBuilder<int>(
              initialData: 0,
              stream: videoScreenBloc.categoriesSearchStream,
              builder: (context, snapshot) {
                return controller.value.isPlaying
                    ? SizedBox.shrink()
                    : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                );
              }),
        ),
        GestureDetector(
          onTap: () {
//            controller.value.isPlaying ? controller.pause() : controller.play();
//            videoScreenBloc.categoriesSearchSink.add(0);
          },
        ),
      ],
    );
  }
}
