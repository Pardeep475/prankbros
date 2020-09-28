import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/videoplayer/VideoScreenBloc.dart';
import 'package:prankbros2/commonwidgets/ease_in_widget.dart';
import 'package:prankbros2/customviews/CommonProgressIndicator.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _videoPlayerController;
  bool startedPlaying = false;
  VideoScreenBloc _videoScreenBloc;

  @override
  void initState() {
    super.initState();
    _videoScreenBloc = new VideoScreenBloc();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    String _videoPath = ModalRoute.of(context).settings.arguments;

    _videoPlayerController = VideoPlayerController.network(_videoPath);

  }

  @override
  void dispose() {
    print("_videoPlayerControllerDispose");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: Dimens.FORTY_FIVE,
            height: Dimens.FORTY_FIVE,
            margin:
            EdgeInsets.only(top: Dimens.FIFTY, left: Dimens.TWENTY),
            child: Card(
              elevation: Dimens.three,
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(Dimens.THIRTY)),
              ),
              child: Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  color: AppColors.light_gray,
                  borderRadius:
                  BorderRadius.all(Radius.circular(Dimens.THIRTY)),
                ),
                child: Center(
                    child:  EaseInWidget(
                      onTap: _onBackPressed,
                      borderRadius: 30.0,
                      child: Image.asset(Images.ArrowBackWhite,
                          height: Dimens.fifteen,
                          width: Dimens.twenty,
                          color: AppColors.black),
                    )),
              ),
            ),
          ),
          Expanded(
            child: Material(
              elevation: 0,
              child: Center(
                child: FutureBuilder<bool>(
                  future: started(),
                  builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.data == true) {
                      return AspectRatio(
                        aspectRatio: _videoPlayerController.value.aspectRatio,
                        child: Stack(
                          children: <Widget>[
                            VideoPlayer(_videoPlayerController),
                            _PlayPauseOverlay(
                              controller: _videoPlayerController,
                              videoScreenBloc: _videoScreenBloc,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return CommonProgressIndicator(true);
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  void _onBackPressed() {
    Navigator.pop(context);
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
            controller.value.isPlaying ? controller.pause() : controller.play();
            videoScreenBloc.categoriesSearchSink.add(0);
          },
        ),
      ],
    );
  }
}

