import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  VideoPlayerController _controller;
  bool isPlaying = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final String videoPath = ModalRoute.of(context).settings.arguments;
    _controller = VideoPlayerController.network(videoPath)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        isPlaying = false;
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isPlaying
          ? Center(child: CommonProgressIndicator(true))
          : Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: _controller.value.initialized
                        ? AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          )
                        : Container(),
                  ),
                ),
                InkWell(
                  onTap: _onBackPressed,
                  child: Container(
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
                            child: Image.asset(Images.ArrowBackWhite,
                                height: Dimens.fifteen,
                                width: Dimens.twenty,
                                color: AppColors.black)),
                      ),
                    ),
                  ),
                ),



              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _onBackPressed() {
    Navigator.pop(context);
  }
}
