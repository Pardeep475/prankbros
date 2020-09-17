import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/bottomsheet/gym_workout_bottomsheet.dart';
import 'package:prankbros2/app/bottomsheet/home_work_out_bottomsheet.dart';
import 'package:prankbros2/app/dashboard/videoplayer/VideoScreenBloc.dart';
import 'package:prankbros2/commonwidgets/commontwidgets.dart';
import 'package:prankbros2/customviews/CommonProgressIndicator.dart';
import 'package:prankbros2/models/workout/GetUserTrainingResponseApi.dart';
import 'package:prankbros2/models/workout/WorkoutDetail2Models.dart';
import 'package:video_player/video_player.dart';

var isHomeWorkOutDownloaded = false;

class WarmUpScreen extends StatefulWidget {
  bool isHomeWorkout;
  WorkoutDetail2Models workoutDetail2Models;

  WarmUpScreen({this.workoutDetail2Models});

  @override
  State<StatefulWidget> createState() => _WarmUpScreenState();
}

class _WarmUpScreenState extends State<WarmUpScreen> {
  List<String> _contentList = new List<String>();

  TextEditingController _textEditingController;

  var listCurrentPosition = 0;
  String _baseUrl = "";
  String videoListUrl = "";
  List<Exercises> _exercisesList = new List();

  VideoPlayerController _videoPlayerController;
  bool startedPlaying = false;
  VideoScreenBloc _videoScreenBloc;
  Future<void> _initializeVideoPlayerFuture;
  List<String> localVideoPaths = [];
  Timer _timer;
  int _start = 0;
  int _timing = 0;

  @override
  void initState() {
    super.initState();

    _textEditingController = new TextEditingController(text: '00:00:00');
    _videoScreenBloc = new VideoScreenBloc();
    _contentListInit();
  }

  void _contentListInit() {
    for (int i = 0; i < 4; i++) {
      _contentList.add(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat');
    }
    try {
      if (widget.workoutDetail2Models != null &&
          widget.workoutDetail2Models.trainings != null &&
          widget.workoutDetail2Models.trainings.exercises != null &&
          widget.workoutDetail2Models.trainings.exercises.length > 0)
        _exercisesList.addAll(widget.workoutDetail2Models.trainings.exercises);
      localVideoPaths = widget.workoutDetail2Models.localPaths;
      print("localVideoPaths${localVideoPaths.length}");
      _baseUrl = widget.workoutDetail2Models.baseUrl;
//      _timing= parseDuration(_exercisesList[0].exerciseTime);
      videoListUrl = localVideoPaths[listCurrentPosition];

      _videoPlayerController = VideoPlayerController.file(File(videoListUrl));
      _initializeVideoPlayerFuture = _videoPlayerController.initialize();

      _videoPlayerController.setLooping(true);
      int timeValue = 0;
      // _workoutDetail2Models = ModalRoute.of(context).settings.arguments;

    } catch (e) {
      debugPrint('Error${e.toString()}');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();


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
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          Navigator.pop(context, true);
        },
        child: Stack(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Material(
                elevation: 0,
                child: Center(
                  child: FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Stack(
                          children: <Widget>[
                            VideoPlayer(_videoPlayerController),
                            _PlayPauseOverlay(
                              controller: _videoPlayerController,
                              videoScreenBloc: _videoScreenBloc,
                              playCLick: (value) {
                                if (value == 0) {
                                  _videoPlayerController.pause();
                                  startedPlaying = false;
                                  setState(() {});
                                } else {
                                  _playVideo();
                                }
                              },
                            ),
                          ],
                        );
                      } else {
                        return CommonProgressIndicator(true);
                      }
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 270,
                child: DraggableScrollableSheet(
                  initialChildSize: 1,
                  minChildSize: 0.30,
                  builder: (BuildContext context, myscrollController) {
                    return widget.workoutDetail2Models != null &&
                            widget.workoutDetail2Models.isHomeWorkout != null &&
                            widget.workoutDetail2Models.isHomeWorkout
                        ? HomeSheetWorkout(
                            contentList: _contentList,
                            myscrollController: myscrollController,
                            time_start: _textEditingController.text,
                            playVideo: () {
                              _playVideo();
                            },
                          )
                        : GymWorkoutBottomSheet(
                            contentList: _contentList,
                            myscrollController: myscrollController,
                          );
                  },
                ),
              ),
            ),
            backButton(context)
          ],
        ),
      ),
    );
  }

  void _playVideo() async {

    print("Position$listCurrentPosition");
    String valueString =
        parseDurationString(_exercisesList[listCurrentPosition].exerciseTime);
    int valueInt =
        parseDurationInt(_exercisesList[listCurrentPosition].exerciseTime);
    _timing = valueInt;
    debugPrint('timing -- $valueString    $valueInt');

    if (!startedPlaying) {
      _videoPlayerController = VideoPlayerController.file(File(videoListUrl))
        ..initialize().then((_) {
          _videoPlayerController.play();
          setState(() {});
        });
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
        "seconds ${Duration(hours: hours, minutes: minutes, seconds: seconds).inSeconds}");
    return Duration(hours: hours, minutes: minutes, seconds: seconds).inSeconds;
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          print("CheckTime$_timing "+"Start $_start");
          if (_start == _timing) {
            timer.cancel();
            if (listCurrentPosition + 1 < localVideoPaths.length) {
              if (_exercisesList.length - 1 == listCurrentPosition) {
                listCurrentPosition = 0;
              }else{
                listCurrentPosition = listCurrentPosition + 1;
              }

              videoListUrl = localVideoPaths[listCurrentPosition];
              _videoPlayerController =
                  VideoPlayerController.file(File(videoListUrl))..initialize();
              startedPlaying = false;
              _start = 0;
              _textEditingController.text = "00:00:00";
              _videoPlayerController.pause();

              print("Position$listCurrentPosition");
              String valueString =
              parseDurationString(_exercisesList[listCurrentPosition].exerciseTime);
              int valueInt = parseDurationInt(_exercisesList[listCurrentPosition].exerciseTime);
              _timing = valueInt;
              print("PositionTiming> $_timing");
            }else{
              if (_exercisesList.length - 1 == listCurrentPosition) {
                listCurrentPosition = 0;
                videoListUrl = localVideoPaths[listCurrentPosition];
                _videoPlayerController =
                VideoPlayerController.file(File(videoListUrl))..initialize();
                startedPlaying = false;
                _start = 0;
                _textEditingController.text = "00:00:00";
                _videoPlayerController.pause();

                print("Position$listCurrentPosition");
                String valueString =
                parseDurationString(_exercisesList[listCurrentPosition].exerciseTime);
                int valueInt = parseDurationInt(_exercisesList[listCurrentPosition].exerciseTime);
                _timing = valueInt;
                print("PositionTiming> $_timing");
              }
            }
          } else {
            _start = _start + 1;

            _textEditingController.text = splitToComponentTimes(Duration(seconds: _start));
          }
        },
      ),
    );
  }

  String splitToComponentTimes(Duration duration) {
    print("duration.inHours${duration.inHours}");
    String sDuration =
        "${duration.inHours}:${duration.inMinutes.remainder(60)}:${(duration.inSeconds.remainder(60))}";
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitHours = twoDigits(duration.inHours.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (twoDigitMinutes == 0) {
      twoDigitMinutes = "00:";
    }
    if (twoDigitMinutes.length == 0 || twoDigitMinutes.length == 1) {
      if (twoDigitMinutes == 0) twoDigitMinutes = "00";
      if (twoDigitMinutes.length == 1) {
        twoDigitMinutes = "0$twoDigitMinutes";
      }
    }
    if (twoDigitHours.length == 0 || twoDigitHours.length == 1) {
      if (twoDigitHours == 0) twoDigitHours = "00";
      if (twoDigitHours.length == 1) {
        twoDigitHours = "0$twoDigitHours:";
      }
    }
    print("TimeTeest$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds");
    return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";

    //return sDuration;
  }
}

class _PlayPauseOverlay extends StatelessWidget {
  _PlayPauseOverlay(
      {Key key, this.controller, this.videoScreenBloc, this.playCLick});

  final VideoPlayerController controller;
  final VideoScreenBloc videoScreenBloc;
  Function(int) playCLick;

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
            if (controller.value.isPlaying) {
              playCLick(0);
            } else {
              playCLick(1);
            }
            videoScreenBloc.categoriesSearchSink.add(0);
          },
        ),
      ],
    );
  }
}
