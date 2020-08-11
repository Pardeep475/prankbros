import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/videoplayer/VideoScreenBloc.dart';
import 'package:prankbros2/models/workout/CommingUpMainModel.dart';
import 'package:prankbros2/models/workout/WorkoutDetail2Models.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:video_player/video_player.dart';

class ComingUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ComingUpState();
}

class _ComingUpState extends State<ComingUp> {
  List<String> _methodList = new List<String>();
  CommingUpMainModel _commingUpMainModel;
  String _baseUrl = "";
  VideoPlayerController _videoPlayerController;
  bool startedPlaying = false;

  VideoScreenBloc _videoScreenBloc;
//  @override
//  void initState() {
//    super.initState();
//    _methodListInit();
//  }

  @override
  void initState() {
    super.initState();
    _videoScreenBloc = new VideoScreenBloc();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _commingUpMainModel = ModalRoute.of(context).settings.arguments;


  

    try {
      if (_commingUpMainModel != null &&
          _commingUpMainModel.exercises != null &&
          _commingUpMainModel.exercises.descriptionEN != null)
        _methodList.add(_commingUpMainModel.exercises.descriptionEN);
      _baseUrl = _commingUpMainModel.baseUrl;
      _videoPlayerController = VideoPlayerController.network('$_baseUrl${_commingUpMainModel.exercises.videoPath}');
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
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<bool> started() async {
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.initialize();
    await _videoPlayerController.play();
    startedPlaying = true;
    debugPrint('started----------------');
    return true;
  }

  void _methodListInit() {
    for (int i = 0; i < 10; i++) {
      _methodList.add(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.');
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




  Widget _comingUpWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: Dimens.forty,
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: Dimens.FORTY_FIVE,
            height: Dimens.FORTY_FIVE,
            margin: EdgeInsets.only(top: Dimens.twenty, left: Dimens.TWENTY),
            child: Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                color: AppColors.light_gray,
                borderRadius: BorderRadius.all(Radius.circular(Dimens.THIRTY)),
              ),
              child: Center(
                  child: Image.asset(Images.ArrowBackWhite,
                      height: Dimens.fifteen,
                      width: Dimens.twenty,
                      color: AppColors.black)),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 5.5,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimens.fifteen),
          width: MediaQuery.of(context).size.width,
          child: Card(
            color: AppColors.white,
            elevation: Dimens.ten,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(Dimens.fifteen)),
            ),
            child: Padding(
              padding: EdgeInsets.all(Dimens.twenty),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _commingUpMainModel.exercises.nameEN != null
                        ? _commingUpMainModel.exercises.nameEN
                        : "",
                    style: TextStyle(
                        fontFamily: Strings.EXO_FONT,
                        fontSize: Dimens.twentySix,
                        color: AppColors.black_text,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: Dimens.fifteen,
                  ),
                  Text(
                    'abdominals, clutes, \nhamstrings'.toUpperCase(),
                    style: TextStyle(
                        letterSpacing: 1.04,
                        fontFamily: Strings.EXO_FONT,
                        fontSize: Dimens.thrteen,
                        color: AppColors.light_text,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _methodList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return _methodItemBuilder(ctxt, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _methodItemBuilder(BuildContext ctxt, int index) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: Dimens.twentyFive,
            ),
            Container(
              height: Dimens.thirty,
              width: Dimens.thirty,
              decoration: BoxDecoration(
                color: AppColors.light_gray,
                borderRadius: BorderRadius.all(Radius.circular(Dimens.ninety)),
              ),
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Dimens.forteen,
                      fontFamily: Strings.EXO_FONT,
                      color: AppColors.black_text),
                ),
              ),
            ),
            SizedBox(
              width: Dimens.twentyOne,
            ),
            Expanded(
              child: Text(
                _methodList[index],
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: Dimens.forteen,
                    fontFamily: Strings.EXO_FONT,
                    color: AppColors.light_text),
              ),
            ),
            SizedBox(
              width: Dimens.twentyFive,
            ),
          ],
        ),
        SizedBox(
          height: Dimens.twenty,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[

        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3,
          child: Material(
            elevation: 0,
            child: Center(
              child: FutureBuilder<bool>(
                future: started(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
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
//        Image.asset(
//          Images.COMING_UP_BACKGROUND,
//          width: MediaQuery.of(context).size.width,
//          height: MediaQuery.of(context).size.height / 3,
//          fit: BoxFit.cover,
//        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 3,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: AppColors.workoutDetail2BackColor,
          ),
        ),
        Scaffold(
          backgroundColor: AppColors.transparent,
          body: _comingUpWidget(),
        ),
      ],
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
