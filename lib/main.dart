import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:prankbros2/app/auth/forgotpassword/ForgotPassword.dart';
import 'package:prankbros2/app/auth/forgotpassword/SendEmail.dart';
import 'package:prankbros2/app/auth/intro/Intro.dart';
import 'package:prankbros2/app/auth/login/Login.dart';
import 'package:prankbros2/app/dashboard/Dashboard.dart';
import 'package:prankbros2/app/dashboard/custom_bottom_navigation_bar/CustomDashboardBottomNestedBar.dart';
import 'package:prankbros2/app/dashboard/fullimageview/FullImageViewScreen.dart';
import 'package:prankbros2/app/dashboard/nutrition/NutritionDetail.dart';
import 'package:prankbros2/app/dashboard/videoplayer/VideoPlayerScreen.dart';
import 'package:prankbros2/app/dashboard/workouts/WarmUpScreen.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/SizeConfig.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Styling.dart';
import 'package:prankbros2/utils/locale/AppLanguage.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';
import 'package:provider/provider.dart';

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
    Strings.FORGOT_PASSWORD_ROUTE: (BuildContext context) => new ForgotPassword(),
    Strings.SEND_EMAIL_ROUTE: (BuildContext context) => new SendEmail(),
    Strings.DASHBOARD_ROUTE: (BuildContext context) => new Dashboard(),
    Strings.CUSTOM_DASHBOARD_ROUTE: (BuildContext context) => new CustomDashboardBottomNestedBar(),
    Strings.WARM_UP_ROUTE: (BuildContext context) => new WarmUpScreen(),
    Strings.NUTRITION_DETAIL_ROUTE: (BuildContext context) => new NutritionDetail(),
    Strings.VIDEO_PLAYER_ROUTE: (BuildContext context) => new VideoPlayerScreen(),
    Strings.FULL_IMAGE_VIEW_SCREEN: (BuildContext context) => new FullImageViewScreen(),
  };
}

//import 'dart:async';
//import 'dart:io';
//
//import 'package:flutter/foundation.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/basic.dart';
//import 'package:image_picker/image_picker.dart';
//
//void main() {
//  runApp(MyApp());
//}
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Image Picker Demo',
//      home: MyHomePage(title: 'Image Picker Example'),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  PickedFile _imageFile;
//  dynamic _pickImageError;
//  String _retrieveDataError;
//
//  final ImagePicker _picker = ImagePicker();
//
//  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
//    final pickedFile = await _picker.getImage(
//      source: source,
//    );
//
//    debugPrint('Image file ---->   ${pickedFile.path}');
//
//    setState(() {
//      _imageFile = pickedFile;
//    });
//  }
//
//  Widget _previewImage() {
//    final Text retrieveError = _getRetrieveErrorWidget();
//    if (retrieveError != null) {
//      return retrieveError;
//    }
//    if (_imageFile != null) {
//      if (kIsWeb) {
//        // Why network?
//        // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
//        return Image.network(_imageFile.path);
//      } else {
//        return Image.file(File(_imageFile.path));
//      }
//    } else if (_pickImageError != null) {
//      return Text(
//        'Pick image error: $_pickImageError',
//        textAlign: TextAlign.center,
//      );
//    } else {
//      return const Text(
//        'You have not yet picked an image.',
//        textAlign: TextAlign.center,
//      );
//    }
//  }
//
//  Future<void> retrieveLostData() async {
//    final LostData response = await _picker.getLostData();
//    if (response.isEmpty) {
//      return;
//    }
//    if (response.file != null) {
//      setState(() {
//        _imageFile = response.file;
//      });
//    } else {
//      _retrieveDataError = response.exception.code;
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      body: Center(
//        child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
//            ? FutureBuilder<void>(
//                future: retrieveLostData(),
//                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//                  switch (snapshot.connectionState) {
//                    case ConnectionState.none:
//                    case ConnectionState.waiting:
//                      return const Text(
//                        'You have not yet picked an image.',
//                        textAlign: TextAlign.center,
//                      );
//                    case ConnectionState.done:
//                      return _previewImage();
//                    default:
//                      if (snapshot.hasError) {
//                        return Text(
//                          'Pick image/video error: ${snapshot.error}}',
//                          textAlign: TextAlign.center,
//                        );
//                      } else {
//                        return const Text(
//                          'You have not yet picked an image.',
//                          textAlign: TextAlign.center,
//                        );
//                      }
//                  }
//                },
//              )
//            : _previewImage(),
//      ),
//      floatingActionButton: Column(
//        mainAxisAlignment: MainAxisAlignment.end,
//        children: <Widget>[
//          FloatingActionButton(
//            onPressed: () {
//              _onImageButtonPressed(ImageSource.gallery, context: context);
//            },
//            heroTag: 'image0',
//            tooltip: 'Pick Image from gallery',
//            child: const Icon(Icons.photo_library),
//          ),
//          Padding(
//            padding: const EdgeInsets.only(top: 16.0),
//            child: FloatingActionButton(
//              onPressed: () {
//                _onImageButtonPressed(ImageSource.camera, context: context);
//              },
//              heroTag: 'image1',
//              tooltip: 'Take a Photo',
//              child: const Icon(Icons.camera_alt),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  Text _getRetrieveErrorWidget() {
//    if (_retrieveDataError != null) {
//      final Text result = Text(_retrieveDataError);
//      _retrieveDataError = null;
//      return result;
//    }
//    return null;
//  }
//}
//
//typedef void OnPickImageCallback();
