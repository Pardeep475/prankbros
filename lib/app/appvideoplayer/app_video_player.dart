import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AppVideoPlayer extends StatefulWidget {
  String videourl;

  AppVideoPlayer(this.videourl);

  @override
  _AppVideoPlayerState createState() => _AppVideoPlayerState(this.videourl);
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  String videourl;

  _AppVideoPlayerState(this.videourl);

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(videourl)
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.initialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Container(
              color: Colors.black,
            ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _controller.dispose();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
