import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prankbros2/app/dashboard/workouts/WarmUpScreen.dart';
import 'package:prankbros2/commonwidgets/ease_in_widget.dart';
import 'package:prankbros2/commonwidgets/progress_percentage_indicator.dart';
import 'package:prankbros2/customviews/BackgroundWidgetWithImage.dart';
import 'package:prankbros2/customviews/CustomViews.dart';
import 'package:prankbros2/models/DailyWorkoutModel.dart';
import 'package:prankbros2/models/WorkoutDetails2Model.dart';
import 'package:prankbros2/models/workout/CommingUpMainModel.dart';
import 'package:prankbros2/models/workout/GetUserTrainingResponseApi.dart';
import 'package:prankbros2/models/workout/WorkoutDetail2Models.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Keys.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Utils.dart';

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

  WorkoutDetail2Models _workoutDetail2Models;
  String _baseUrl = "";
  List<Exercises> _exercisesList = new List();
  String _progress = "-";

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

  Future<void> _onSelectNotification(String json) async {
    final obj = jsonDecode(json);

    if (obj['isSuccess']) {
      //OpenFile.open(obj['filePath']);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('${obj['error']}'),
        ),
      );
    }
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
      debugPrint('workoutlist :  ${_workoutList[0].workoutList[i].title} ');
    }
    for (int i = 0; i < _workoutList[0].warmUpList.length; i++) {
      debugPrint('warmuplist :  ${_workoutList[0].warmUpList[i].title}');
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
        Container(
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
                child: FlatButton(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(Dimens.THIRTY)),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Image.asset(Images.ArrowBackWhite,
                  height: Dimens.fifteen,
                  width: Dimens.twenty,
                  color: AppColors.black),
            )),
          ),
        ),
        SizedBox(
          height: Dimens.sixty,
        ),
        Padding(
          padding: EdgeInsets.only(left: Dimens.thirtyFive),
          child: Text(
            _workoutDetail2Models.trainings.nameEN != null
                ? _workoutDetail2Models.trainings.nameEN
                : "",
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
                    '${_workoutDetail2Models.trainings.workoutTime}',
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
            _workoutDetail2Models.trainings.descriptionEN != null
                ? _workoutDetail2Models.trainings.descriptionEN
                : "",
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
                          _exercisesList[index], _exercisesList.length, index);
                    }, childCount: _exercisesList.length),
                  ),
//                  SliverPadding(
//                    padding: EdgeInsets.only(top: Dimens.twenty),
//                  ),
//                  SliverList(
//                    delegate: SliverChildBuilderDelegate(
//                        (BuildContext context, int index) {
//                      return _mainItemBuilder();
//                    }, childCount: _workoutList[0].workoutList.length),
//                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _mainItemClick(Exercises item) {
    Navigator.pushNamed(context, Strings.COMING_UP_ROUTE,
        arguments: CommingUpMainModel(baseUrl: _baseUrl, exercises: item));
//    Navigator.push(
//        context, MaterialPageRoute(builder: (context) => ComingUp()));
  }

  Widget _mainItemBuilder(Exercises item, int size, int index) {
    return Material(
      color: AppColors.transparent,
      child: EaseInWidget(
        onTap: () {
          _mainItemClick(item);
        },
        child: Container(
          margin: EdgeInsets.only(
              left: Dimens.twenty,
              top: Dimens.twenty,
              bottom: size - 1 == index ? Dimens.seventeen : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
//              SizedBox(
//                child: item.nameEN != null || item.nameEN != ''
//                    ? Text(
//                  item.nameEN.toUpperCase(),
//                        style: TextStyle(
//                            letterSpacing: 1.04,
//                            fontWeight: FontWeight.w600,
//                            fontSize: Dimens.fifteen,
//                            color: AppColors.unSelectedTextRadioColor,
//                            fontFamily: Strings.EXO_FONT),
//                      )
//                    : SizedBox(
//                        height: 0,
//                      ),
//              ),
//              SizedBox(
//                height: Dimens.eight,
//              ),
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimens.eight)),
                    child: CachedNetworkImage(
                      width: Dimens.ninety,
                      height: Dimens.ninety,
                      imageUrl: item.imagePath != null
                          ? '$_baseUrl${item.imagePath}'
                          : "",
                      imageBuilder: (context, imageProvider) => Container(
                        width: Dimens.ninety,
                        height: Dimens.ninety,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) => Utils.getAssetImage(
                        Dimens.ninety,
                        Dimens.ninety,
                      ),
                      errorWidget: (context, url, error) =>
                          Utils.getImagePlaceHolderWidgetProfile(
                        context: context,
                        img: Images.DUMMY_WORKOUT,
                        width: Dimens.ninety,
                        height: Dimens.ninety,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Dimens.fifteen,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.nameEN,
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
                          item.exerciseTime,
                          style: TextStyle(
                              letterSpacing: 1.04,
                              fontWeight: FontWeight.w500,
                              fontSize: Dimens.fifteen,
                              color: AppColors.light_text,
                              fontFamily: Strings.EXO_FONT),
                        ),
                      ],
                    ),
                  )
                ],
              ),
//              SizedBox(
//                child: size - 1 != index
//                    ? Row(
//                        children: <Widget>[
//                          Expanded(
//                            child: Divider(
//                              height: Dimens.one,
//                              color: AppColors.divider_color_2,
//                            ),
//                          ),
//                          Container(
//                            decoration: BoxDecoration(
//                                borderRadius: BorderRadius.all(
//                                    Radius.circular(Dimens.twenty)),
//                                border: Border.all(
//                                    color: AppColors.divider_color_2,
//                                    width: Dimens.one)),
//                            child: Padding(
//                              padding: EdgeInsets.symmetric(
//                                  horizontal: Dimens.twenty,
//                                  vertical: Dimens.eight),
//                              child: Text(
//                                dailyWorkoutModel.rest,
//                                style: TextStyle(
//                                    fontWeight: FontWeight.w500,
//                                    fontSize: Dimens.forteen,
//                                    letterSpacing: 1.04,
//                                    fontFamily: Strings.EXO_FONT,
//                                    color: AppColors.unSelectedTextRadioColor),
//                              ),
//                            ),
//                          ),
//                          SizedBox(
//                            width: Dimens.twentyFive,
//                            child: Divider(
//                              height: Dimens.one,
//                              color: AppColors.divider_color_2,
//                            ),
//                          ),
//                        ],
//                      )
//                    : SizedBox(
//                        height: 0,
//                      ),
//              )
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

  var currentDownloadingPos = 0;
  var totalLength = 0;

  void _downloadButtonPressed(BuildContext context) {
//    _workoutDetail2Models

    var baseUrl = _workoutDetail2Models.baseUrl;
    var fileUrl = _exercisesList[currentDownloadingPos].videoPath;
    totalLength = _exercisesList.length;
    ;
    setState(() {
      _isLoading = true;
    });

    downloadFile(
            url: baseUrl + "${fileUrl}",
            fileName: "${fileUrl.split('/').last}",
            dir: "prankpros")
        .then((filePath) {
      print("filePath${filePath}");
    });
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/$uniqueFileName.mp4';

    return path;
  }

  Future<Directory> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await DownloadsPathProvider.downloadsDirectory;
    }

    // in this example we are using only Android and iOS so I can assume
    // that you are not trying it for other platforms and the if statement
    // for iOS is unnecessary

    // iOS directory visible to user
    return await getApplicationDocumentsDirectory();
  }

  Future<bool> requestPermission(
    Permission permission,
  ) async {
    Map<Permission, PermissionStatus> statuses = await [permission].request();
    PermissionStatus permissionStatus = statuses[permission];
    if (permissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  final Dio _dio = Dio();

  Future<bool> _startDownload(String savePath, String _fileUrl) async {
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };

    try {
      final response = await _dio.download(_fileUrl, savePath,
          onReceiveProgress: _onReceiveProgress);
      print("DownloadedFilePath$savePath");
      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = savePath;
      localPaths.add(savePath);
      return response.statusCode == 200;
    } catch (ex) {
      result['error'] = ex.toString();
    } finally {
      print("Downloaded");
    }
  }

  var progressVal = "0";

  void _onReceiveProgress(int received, int total) {
    if (total != -1) {
      setState(() {
        _progress = (received / total * 100).toStringAsFixed(0) + "%";
        print("_progress$_progress");
      });
    }
  }

  List<String> localPaths = [];

  Future<bool> downloadFile({String url, String fileName, String dir}) async {
    print("url${url}");

    final dir = await _getDownloadDirectory();
    final isPermissionStatusGranted =
        await requestPermission(Permission.storage);

    if (isPermissionStatusGranted) {
      final savePath = path.join(dir.path, fileName);

      File(savePath).exists().then((isExist) {
        if (isExist) {
          localPaths.add(savePath);
          if (totalLength - 1 == currentDownloadingPos) {
            setState(() {
              _isLoading = false;
            });
            _workoutDetail2Models.localPaths = localPaths;
            print(
                "_workoutDetail2Models.localPaths${_workoutDetail2Models.localPaths.length}");
            navigateToNextScreen();
          } else {
            print("NextUrl$currentDownloadingPos");

            var baseUrl = _workoutDetail2Models.baseUrl;
            currentDownloadingPos = currentDownloadingPos + 1;
            var fileUrl = _exercisesList[currentDownloadingPos].videoPath;
            print("NextUrl$fileUrl");
            downloadFile(
                url: baseUrl + fileUrl,
                fileName: "${fileUrl.split('/').last}",
                dir: "prankpros");
          }
        } else {
          downoadNewFile(savePath, url);
        }
      });
    } else {
      // handle the scenario when user declines the permissions
    }
  }

  @override
  Widget build(BuildContext context) {
    //pr = ProgressDialog(context);
    return Stack(
      children: <Widget>[
        BackgroundWidgetWithImage(
          imagePath: '$_baseUrl${_workoutDetail2Models.trainings.imagePath}',
          curveColor: AppColors.workoutDetail2BackColor,
        ),
        Scaffold(
          backgroundColor: AppColors.transparent,
          body: _WorkoutDetails2Widget(),
        ),
        ProgressIndicatorDownloadFiles(
          isLoading: _isLoading,
          currentFile: currentDownloadingPos,
          progressvalue: _progress,
          totalFiles: totalLength,
        )
      ],
    );
  }

  void downoadNewFile(String savePath, String url) async {
    var isDownloaded = await _startDownload(savePath, url);

    if (isDownloaded != null &&
        isDownloaded &&
        totalLength - 1 == currentDownloadingPos) {
      setState(() {
        _isLoading = false;
      });
      _workoutDetail2Models.localPaths = localPaths;
      navigateToNextScreen();
    } else if (isDownloaded != null && isDownloaded) {
      print("NextUrl$currentDownloadingPos");
      isDownloaded = false;
      var baseUrl = _workoutDetail2Models.baseUrl;
      currentDownloadingPos = currentDownloadingPos + 1;
      var fileUrl = _exercisesList[currentDownloadingPos].videoPath;
      print("NextUrl$fileUrl");
      downloadFile(
          url: baseUrl + fileUrl,
          fileName: "${fileUrl.split('/').last}",
          dir: "prankpros");
    }
  }

  void navigateToNextScreen() {
    if (_workoutDetail2Models.isHomeWorkout) {
      Navigator.pushNamed(
          context,
          _workoutDetail2Models.isHomeWorkout
              ? Strings.COMING_UP_NEXT_WORKOUT_ROUTE
              : Strings.WARM_UP_SCREEN_ROUTE,
          arguments: _workoutDetail2Models);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WarmUpScreen(
                    workoutDetail2Models: _workoutDetail2Models,
                  )));
    }
  }
}
