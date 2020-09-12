import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:prankbros2/app/auth/forgotpassword/ForgotPassword.dart';
import 'package:prankbros2/app/auth/forgotpassword/SendEmail.dart';
import 'package:prankbros2/app/auth/intro/Intro.dart';
import 'package:prankbros2/app/auth/login/Login.dart';
import 'package:prankbros2/app/dashboard/Dashboard.dart';
import 'package:prankbros2/app/dashboard/custom_bottom_navigation_bar/CustomDashboardBottomNestedBar.dart';
import 'package:prankbros2/app/dashboard/fullimageview/FullImageViewScreen.dart';
import 'package:prankbros2/app/dashboard/nutrition/NutritionDetail.dart';
import 'package:prankbros2/app/dashboard/videoplayer/VideoPlayerScreen.dart';
import 'package:prankbros2/app/dashboard/workouts/ComingUp.dart';
import 'package:prankbros2/app/dashboard/workouts/WarmUpScreen.dart';
import 'package:prankbros2/app/dashboard/workouts/WorkoutDetails.dart';
import 'package:prankbros2/app/dashboard/workouts/WorkoutDetails2.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/SizeConfig.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Styling.dart';
import 'package:prankbros2/utils/locale/AppLanguage.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';
import 'package:provider/provider.dart';

import 'app/dashboard/workouts/ComingUpNextWorkout.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SessionManager sessionManager = new SessionManager();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  sessionManager.isInstalledFirstTime().then((value) {
    print('value is ==>$value');
    if (value != null && value) {
      sessionManager.isLogin().then((value) {
        if (value != null && value) {
          runApp(MyApp(appLanguage, Strings.DASHBOARD_ROUTE));
        } else {
          runApp(MyApp(appLanguage, Strings.LOGIN_ROUTE));
        }
      });
//      runApp(MyApp(appLanguage, Login()));
    } else {
      runApp(MyApp(appLanguage, Strings.INTRO_ROUTE));
    }
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
//  final Widget startingWidget;
  final String startingWidget;
  final AppLanguage appLanguage;

  MyApp(this.appLanguage, this.startingWidget);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return ChangeNotifierProvider<AppLanguage>(
            create: (context) => appLanguage,
            child: Consumer<AppLanguage>(
              builder: (context, model, child) {
                return MaterialApp(
                  locale: model.appLocal,
                  supportedLocales: [
                    Locale('en', 'US'),
                    Locale('de', ''),
                  ],
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  title: "Prank bros",
                  debugShowCheckedModeBanner: false,
                  initialRoute: this.startingWidget,
                  routes: routes,
                  theme: appTheme,
                );
              },
            ),
          );
        });
      },
    );
  }

  var routes = <String, WidgetBuilder>{
    Strings.LOGIN_ROUTE: (BuildContext context) => new Login(),
    Strings.INTRO_ROUTE: (BuildContext context) => new Intro(),
    Strings.FORGOT_PASSWORD_ROUTE: (BuildContext context) =>
    new ForgotPassword(),
    Strings.SEND_EMAIL_ROUTE: (BuildContext context) => new SendEmail(),
    Strings.DASHBOARD_ROUTE: (BuildContext context) => new Dashboard(),
    Strings.CUSTOM_DASHBOARD_ROUTE: (BuildContext context) =>
    new CustomDashboardBottomNestedBar(),
    Strings.WARM_UP_ROUTE: (BuildContext context) => new WarmUpScreen(),
    Strings.NUTRITION_DETAIL_ROUTE: (BuildContext context) =>
    new NutritionDetail(),
    Strings.VIDEO_PLAYER_ROUTE: (BuildContext context) =>
    new VideoPlayerScreen(),
    Strings.FULL_IMAGE_VIEW_SCREEN: (BuildContext context) =>
    new FullImageViewScreen(),
    Strings.WORKOUT_DETAILS_FIRST_ROUTE: (BuildContext context) =>
    new WorkoutDetails(),
    Strings.WORKOUT_DETAILS_SECOND_ROUTE: (BuildContext context) =>
    new WorkoutDetails2(),
    Strings.COMING_UP_ROUTE: (BuildContext context) => new ComingUp(),
    Strings.COMING_UP_NEXT_WORKOUT_ROUTE: (BuildContext context) =>
    new ComingUpNextWorkout(),
    Strings.WARM_UP_SCREEN_ROUTE: (BuildContext context) => new WarmUpScreen(),
  };

  Route<dynamic> customGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Strings.LOGIN_ROUTE:
        return PageTransition(
          child: Login(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case Strings.INTRO_ROUTE:
        return PageTransition(
          child: Intro(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case Strings.FORGOT_PASSWORD_ROUTE:
        return PageTransition(
          child: ForgotPassword(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case Strings.SEND_EMAIL_ROUTE:
        return PageTransition(
          child: SendEmail(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case Strings.FORGOT_PASSWORD_ROUTE:
        return PageTransition(
          child: ForgotPassword(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case Strings.DASHBOARD_ROUTE:
        return PageTransition(
          child: Dashboard(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case Strings.CUSTOM_DASHBOARD_ROUTE:
        return PageTransition(
          child: CustomDashboardBottomNestedBar(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case Strings.WARM_UP_ROUTE:
        return PageTransition(
          child: WarmUpScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case Strings.NUTRITION_DETAIL_ROUTE:
        return PageTransition(
          child: NutritionDetail(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case Strings.VIDEO_PLAYER_ROUTE:
        return PageTransition(
          child: VideoPlayerScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case Strings.FULL_IMAGE_VIEW_SCREEN:
        return PageTransition(
          child: FullImageViewScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case Strings.WORKOUT_DETAILS_FIRST_ROUTE:
        return PageTransition(
          child: WorkoutDetails(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case Strings.WORKOUT_DETAILS_SECOND_ROUTE:
        return PageTransition(
          child: WorkoutDetails2(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case Strings.COMING_UP_ROUTE:
        return PageTransition(
          child: ComingUp(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case Strings.COMING_UP_NEXT_WORKOUT_ROUTE:
        return PageTransition(
          child: ComingUpNextWorkout(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case Strings.WARM_UP_SCREEN_ROUTE:
        return PageTransition(
          child: WarmUpScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      default:
        {
          return PageTransition(
            child: Login(),
            type: PageTransitionType.rightToLeft,
            settings: settings,
          );
        }
    }
  }
}



/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/videoplayer/VideoScreenBloc.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(
    MaterialApp(
      home: _PlayerVideoAndPopPage(),
    ),
  );
}

class _App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: const ValueKey<String>('home_page'),
        appBar: AppBar(
          title: const Text('Video player example'),
          actions: <Widget>[
            IconButton(
              key: const ValueKey<String>('push_tab'),
              icon: const Icon(Icons.navigation),
              onPressed: () {
                Navigator.push<_PlayerVideoAndPopPage>(
                  context,
                  MaterialPageRoute<_PlayerVideoAndPopPage>(
                    builder: (BuildContext context) => _PlayerVideoAndPopPage(),
                  ),
                );
              },
            )
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.cloud),
                text: "Remote",
              ),
              Tab(icon: Icon(Icons.insert_drive_file), text: "Asset"),
              Tab(icon: Icon(Icons.list), text: "List example"),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _BumbleBeeRemoteVideo(),
            _ButterFlyAssetVideo(),
            _ButterFlyAssetVideoInList(),
          ],
        ),
      ),
    );
  }
}

class _ButterFlyAssetVideoInList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _ExampleCard(title: "Item a"),
        _ExampleCard(title: "Item b"),
        _ExampleCard(title: "Item c"),
        _ExampleCard(title: "Item d"),
        _ExampleCard(title: "Item e"),
        _ExampleCard(title: "Item f"),
        _ExampleCard(title: "Item g"),
        Card(
            child: Column(children: <Widget>[
          Column(
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.cake),
                title: Text("Video video"),
              ),
              Stack(
                  alignment: FractionalOffset.bottomRight +
                      const FractionalOffset(-0.1, -0.1),
                  children: <Widget>[
                    _ButterFlyAssetVideo(),
                    Image.asset('assets/flutter-mark-square-64.png'),
                  ]),
            ],
          ),
        ])),
        _ExampleCard(title: "Item h"),
        _ExampleCard(title: "Item i"),
        _ExampleCard(title: "Item j"),
        _ExampleCard(title: "Item k"),
        _ExampleCard(title: "Item l"),
      ],
    );
  }
}

/// A filler card to show the video in a list of scrolling contents.
class _ExampleCard extends StatelessWidget {
  const _ExampleCard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.airline_seat_flat_angled),
            title: Text(title),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('BUY TICKETS'),
                onPressed: () {
                  */
/* ... *//*

                },
              ),
              FlatButton(
                child: const Text('SELL TICKETS'),
                onPressed: () {
                  */
/* ... *//*

                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ButterFlyAssetVideo extends StatefulWidget {
  @override
  _ButterFlyAssetVideoState createState() => _ButterFlyAssetVideoState();
}

class _ButterFlyAssetVideoState extends State<_ButterFlyAssetVideo> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/Butterfly-209.mp4');

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          const Text('With assets mp4'),
          Container(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  _PlayPauseOverlay(controller: _controller),
                  VideoProgressIndicator(_controller, allowScrubbing: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BumbleBeeRemoteVideo extends StatefulWidget {
  @override
  _BumbleBeeRemoteVideoState createState() => _BumbleBeeRemoteVideoState();
}

class _BumbleBeeRemoteVideoState extends State<_BumbleBeeRemoteVideo> {
  VideoPlayerController _controller;

  Future<ClosedCaptionFile> _loadCaptions() async {
    final String fileContents = await DefaultAssetBundle.of(context)
        .loadString('assets/bumble_bee_captions.srt');
    return SubRipCaptionFile(fileContents);
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      closedCaptionFile: _loadCaptions(),
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(padding: const EdgeInsets.only(top: 20.0)),
          const Text('With remote mp4'),
          Container(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  ClosedCaption(text: _controller.value.caption.text),
                  _PlayPauseOverlay(controller: _controller),
                  VideoProgressIndicator(_controller, allowScrubbing: true),
                ],
              ),
            ),
          ),
        ],
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
            controller.value.isPlaying ? controller.pause() : controller.play();
            videoScreenBloc.categoriesSearchSink.add(0);
          },
        ),
      ],
    );
  }
}

class _PlayerVideoAndPopPage extends StatefulWidget {
  @override
  _PlayerVideoAndPopPageState createState() => _PlayerVideoAndPopPageState();
}

class _PlayerVideoAndPopPageState extends State<_PlayerVideoAndPopPage> {
  VideoPlayerController _videoPlayerController;
  bool startedPlaying = false;
  VideoScreenBloc _videoScreenBloc;

  @override
  void initState() {
    super.initState();
    _videoScreenBloc = new VideoScreenBloc();
    _videoPlayerController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
    _videoPlayerController.addListener(() {
//      if (startedPlaying && !_videoPlayerController.value.isPlaying) {
//        Navigator.pop(context);
//      }
    });
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

  @override
  Widget build(BuildContext context) {
    return Material(
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
              );
            } else {
              return const Text('waiting for video to load');
            }
          },
        ),
      ),
    );
  }
  void _onBackPressed() {
    Navigator.pop(context);
  }
}
*/
