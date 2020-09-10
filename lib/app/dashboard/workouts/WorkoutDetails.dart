import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/workouts/workoutdetails/WorkoutDetailBloc.dart';
import 'package:prankbros2/commonwidgets/ease_in_widget.dart';
import 'package:prankbros2/customviews/CommonProgressIndicator.dart';
import 'package:prankbros2/models/MotivationHistoryModel.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/models/workout/GetUserTrainingResponseApi.dart';
import 'package:prankbros2/models/workout/WorkoutDetail2Models.dart';
import 'package:prankbros2/popups/CustomChangeWeekDialog.dart';
import 'package:prankbros2/popups/CustomResetRedDialog.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Utils.dart';
import 'package:shimmer/shimmer.dart';

class WorkoutDetails extends StatefulWidget {
  WorkoutDetails({this.onPush});

  final ValueChanged<int> onPush;

  @override
  State<StatefulWidget> createState() =>
      _WorkoutDetailsState(onPush: this.onPush);
}

class _WorkoutDetailsState extends State<WorkoutDetails> {
  _WorkoutDetailsState({this.onPush});

  final ValueChanged<int> onPush;
  SessionManager _sessionManager;
  String _screenName = "Gym";
  bool isHomeWorkout = false;
  String _accessToken = "";
  String _traingWeek = "";
  String _influencerId = "";
  WorkoutDetailBloc _workoutDetailBloc;
  String _baseUrl = "";
  GetUserTrainingResponseApi _getUserTrainingResponseApi;

  @override
  void initState() {
    super.initState();
    _workoutDetailBloc = new WorkoutDetailBloc();
    _sessionManager = new SessionManager();
  }

  void _backPressed() {
    print('back button pressed');
    getRootNavigator(context).maybePop();
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    debugPrint('size/7    ${MediaQuery.of(context).size.width}');
    debugPrint('size/7    ${MediaQuery.of(context).size.width / 8}');
    debugPrint('size/7    ${MediaQuery.of(context).size.width / 6}');
    _screenName = ModalRoute.of(context).settings.arguments;
    if (_screenName == "Gym") {
      isHomeWorkout = false;
    } else {
      isHomeWorkout = true;
    }
    _sessionManager.getUserModel().then((value) {
      debugPrint("userdata   :        $value");
      if (value != null) {
        UserDetails userData = UserDetails.fromJson(value);
        debugPrint('userdata:   :-  ${userData.id}     ${userData.email}');
        _accessToken = userData.accessToken.toString();
        _influencerId = userData.influencerId.toString();
        _traingWeek = userData.trainingWeek.toString();
        _traingWeek = 1.toString();
        debugPrint('screen name --->   $_screenName');
        debugPrint('training week --->   $_traingWeek');
        debugPrint('influencer id --->   $_influencerId');
        debugPrint('access token --->   $_accessToken');

        _getUserTraining();
      }
    });
  }

  void _getUserTraining() {
    Utils.checkConnectivity().then((value) {
      if (value) {
        _workoutDetailBloc.getWorkoutDetail(
            screenType: _screenName,
            influencerId: _influencerId,
            trainingWeek: _traingWeek,
            context: context,
            accessToken: _accessToken);
      } else {
        Navigator.pop(context);
        Utils.showSnackBar(
            Strings.please_check_your_internet_connection, context);
      }
    });
  }

  void _editButtonPressed() {
    if (_getUserTrainingResponseApi == null) return;
    if (_getUserTrainingResponseApi.weekNameList == null) return;
    if (_getUserTrainingResponseApi.weekNameList.length > 0) return;
    showDialog(
        context: context,
        builder: (_) => CustomResetRedDialog(
              endRange: _getUserTrainingResponseApi.weekNameList.length,
            ));
  }

  void _selectWeeksPressed() {
    if (_getUserTrainingResponseApi == null) return;
    if (_getUserTrainingResponseApi.weekNameList == null) return;
    if (_getUserTrainingResponseApi.weekNameList.length > 0) return;
    List<String> _list = new List();
    for (int i = 0; i < _list.length; i++) {
      _list.add('${i + 1}');
    }
    showDialog(
        context: context,
        builder: (_) => CustomChangeWeekDialog(
              list: _list,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.white,
        child: StreamBuilder<int>(
            initialData: 0,
            stream: _workoutDetailBloc.progressStream,
            builder: (context, progressIndicatorSnapshot) {
              if (progressIndicatorSnapshot.data == 0) {
                return Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            colors: [
                              AppColors.blueGradientColor,
                              AppColors.pinkGradientColor
                            ],
                            begin: Alignment.bottomLeft,
                          )),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: Dimens.forty,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  InkWell(
                                    onTap: _backPressed,
                                    splashColor: AppColors.light_gray,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Dimens.twenty,
                                          horizontal: Dimens.twenty),
                                      child: Image.asset(
                                        Images.ArrowBackWhite,
                                        color: AppColors.white,
                                        height: Dimens.fifteen,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '$_screenName Workout'.toUpperCase(),
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontFamily: Strings.EXO_FONT,
                                        fontSize: Dimens.forteen,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  InkWell(
                                    onTap: _editButtonPressed,
                                    splashColor: AppColors.light_gray,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Dimens.twenty,
                                          horizontal: Dimens.fifteen),
                                      child: Image.asset(
                                        Images.ICON_EDIT,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                height: Dimens.one,
                                color: AppColors.divider_color,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Dimens.twentySeven,
                            right: Dimens.twentySeven,
                            top: Dimens.twentySeven,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Workouts this week'.toUpperCase(),
                              style: TextStyle(
                                  color: AppColors.black_text,
                                  fontSize: Dimens.eighteen,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: Strings.EXO_FONT),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: 3,
                              itemBuilder: (context, pos) {
                                return Shimmer.fromColors(
                                  child: Container(
                                    height:  Dimens.oneHundredEightyFive,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    margin: EdgeInsets.only(
                                        right: 25, left: 25, top: 15),
                                  ),
                                  baseColor: Colors.grey[400],
                                  highlightColor: Colors.white,
                                );
                              }),
                        )
                      ],
                    ),
                    CommonProgressIndicator(true),
                  ],
                );
              } else if (progressIndicatorSnapshot.data == 1) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          AppColors.blueGradientColor,
                          AppColors.pinkGradientColor
                        ],
                        begin: Alignment.bottomLeft,
                      )),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: Dimens.forty,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: InkWell(
                                      onTap: _backPressed,
                                      child: Image.asset(
                                        Images.ArrowBackWhite,
                                        color: AppColors.white,
                                        height: Dimens.fifteen,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '$_screenName Workout'.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontFamily: Strings.EXO_FONT,
                                        fontSize: Dimens.forteen,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: _editButtonPressed,
                                      splashColor: AppColors.light_gray,
                                      child: Image.asset(
                                        Images.ICON_EDIT,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: Dimens.one,
                            color: AppColors.divider_color,
                          ),
                          SizedBox(
                            height: Dimens.twentySix,
                          ),
                          InkWell(
                            onTap: _selectWeeksPressed,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: Dimens.twentyFive,
                                ),
                                Text(
                                  'Week $_traingWeek',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: Dimens.twentySeven,
                                      fontFamily: Strings.EXO_FONT),
                                ),
                                SizedBox(
                                  width: Dimens.twenty,
                                ),
                                Image.asset(
                                  Images.ICON_DOWN_ARROW,
                                  height: Dimens.sixteen,
                                  width: Dimens.sixteen,
                                  color: AppColors.white,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Dimens.forty,
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder<GetUserTrainingResponseApi>(
                        initialData: null,
                        stream: _workoutDetailBloc.contentStream,
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            _getUserTrainingResponseApi = snapshot.data;
                            _baseUrl = snapshot.data.awsEndpointUrl;

                            List<MotivationHistoryItem> _list =
                                _calanderData(snapshot.data.workoutActivities);

                            return Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: Dimens.seventy,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _list.length,
                                        itemBuilder: (BuildContext context,
                                            int position) {
                                          if (_list[position].isSelected) {
                                            return calendarItemSelected(
                                                _list[position]
                                                    .weekDay
                                                    .toUpperCase(),
                                                _list[position].date);
                                          } else {
                                            return calendarItemUnselected(
                                                _list[position]
                                                    .weekDay
                                                    .toUpperCase(),
                                                _list[position].date);
                                          }
                                        }),
//                                    child: ListView(
//                                      scrollDirection: Axis.horizontal,
//                                      children: <Widget>[
//                                        calendarItemUnselected('MO', '01'),
//                                        calendarItemUnselected('DI', '02'),
//                                        calendarItemUnselected('MI', '03'),
//                                        calendarItemSelected('DO', '04'),
//                                        calendarItemUnselected('FR', '05'),
//                                        calendarItemUnselected('SA', '06'),
//                                        calendarItemUnselected('SO', '07'),
//                                      ],
//                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimens.eight,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimens.twentySeven),
                                    child: Text(
                                      'Workouts this week'.toUpperCase(),
                                      style: TextStyle(
                                          color: AppColors.black_text,
                                          fontSize: Dimens.eighteen,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: Strings.EXO_FONT),
                                    ),
                                  ),
                                  if (snapshot.data.trainings != null &&
                                      snapshot.data.trainings.length > 0)
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Dimens.twentyFive),
                                        child: ListView.builder(
                                            padding: EdgeInsets.only(
                                                top: Dimens.fifteen),
                                            itemCount:
                                                snapshot.data.trainings.length,
                                            itemBuilder: (context, index) {
                                              return EaseInWidget(
                                                  onTap: () {
                                                    _mainItemClick(snapshot
                                                        .data.trainings[index]);
                                                  },
                                                  child: mainListItem(snapshot
                                                      .data.trainings[index],data: snapshot.data));
                                            }),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        })
                  ],
                );
              } else {
                return Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          AppColors.blueGradientColor,
                          AppColors.pinkGradientColor
                        ],
                        begin: Alignment.bottomLeft,
                      )),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: Dimens.forty,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                onTap: _backPressed,
                                splashColor: AppColors.light_gray,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: Dimens.twenty,
                                      horizontal: Dimens.twenty),
                                  child: Image.asset(
                                    Images.ArrowBackWhite,
                                    color: AppColors.white,
                                    height: Dimens.fifteen,
                                  ),
                                ),
                              ),
                              Text(
                                '$_screenName Workout'.toUpperCase(),
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontFamily: Strings.EXO_FONT,
                                    fontSize: Dimens.forteen,
                                    fontWeight: FontWeight.w500),
                              ),
                              InkWell(
                                onTap: _editButtonPressed,
                                splashColor: AppColors.light_gray,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: Dimens.twenty,
                                      horizontal: Dimens.fifteen),
                                  child: Image.asset(
                                    Images.ICON_EDIT,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            height: Dimens.one,
                            color: AppColors.divider_color,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'No value found',
                          style: TextStyle(
                              color: AppColors.black_text,
                              fontFamily: Strings.EXO_FONT,
                              fontWeight: FontWeight.w700,
                              fontSize: Dimens.thirty),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }

  void _mainItemClick(Trainings trainings) {
    Navigator.pushNamed(context, Strings.WORKOUT_DETAILS_SECOND_ROUTE,
        arguments: WorkoutDetail2Models(
            baseUrl: _baseUrl,
            trainings: trainings,
            isHomeWorkout: isHomeWorkout));
//    Navigator.push(
//        context, MaterialPageRoute(builder: (context) => WorkoutDetails2()));
  }

  Widget calendarItemSelected(String day, String date) {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Image.asset(
            Images.ICON_ACTIVE_DAY,
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  day,
                  style: TextStyle(
                      letterSpacing: 1.43,
                      color: AppColors.white,
                      fontFamily: Strings.EXO_FONT,
                      fontWeight: FontWeight.w600,
                      fontSize: Dimens.ten),
                ),
                SizedBox(
                  height: Dimens.six,
                ),
                Text(
                  date,
                  style: TextStyle(
                      color: AppColors.white,
                      fontFamily: Strings.EXO_FONT,
                      fontWeight: FontWeight.w700,
                      fontSize: Dimens.thrteen),
                ),
                SizedBox(
                  height: Dimens.six,
                ),
                Container(
                  height: Dimens.eight,
                  width: Dimens.eight,
                  decoration: BoxDecoration(
                    color: AppColors.pink_stroke,
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimens.twenty)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget calendarItemUnselected(String day, String date) {
    return Container(
      width: MediaQuery.of(context).size.width / 7.3,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              day,
              style: TextStyle(
                  letterSpacing: 1.43,
                  color: AppColors.calendarWeekNameColor,
                  fontFamily: Strings.EXO_FONT,
                  fontWeight: FontWeight.w500,
                  fontSize: Dimens.ten),
            ),
            SizedBox(
              height: Dimens.six,
            ),
            Text(
              date,
              style: TextStyle(
                  color: AppColors.calendarDateNameColor,
                  fontFamily: Strings.EXO_FONT,
                  fontWeight: FontWeight.w700,
                  fontSize: Dimens.thrteen),
            ),
            SizedBox(
              height: Dimens.six,
            ),
            Container(
              height: Dimens.eight,
              width: Dimens.eight,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(Dimens.twenty)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mainListItem(Trainings trainings,{GetUserTrainingResponseApi data}) {
    if (trainings == null) return SizedBox();
    return Column(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(Dimens.fifteen)),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            height: Dimens.oneHundredEightyFive,
//            decoration: BoxDecoration(
//                borderRadius: BorderRadius.all(Radius.circular(Dimens.fifteen)),
//                image: DecorationImage(
//                  image: AssetImage(Images.DUMMY_WORKOUT),
//                  fit: BoxFit.cover,
//                )),
            child: Stack(
              children: <Widget>[
                CachedNetworkImage(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  imageUrl: trainings.imagePath != null
                      ? '$_baseUrl${trainings.imagePath}'
                      : "",
                  imageBuilder: (context, imageProvider) => Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) =>
                      Utils.getImagePlaceHolderWidgetProfile(
                          context: context,
                          img: Images.DUMMY_WORKOUT,
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width),
                  errorWidget: (context, url, error) =>
                      Utils.getImagePlaceHolderWidgetProfile(
                          context: context,
                          img: Images.DUMMY_WORKOUT,
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width),
                ),
                Container(
                  color: Colors.black.withOpacity(0.5),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimens.thirty, vertical: Dimens.twentyFive),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        trainings.nameEN != null ? trainings.nameEN : "",
                        style: TextStyle(
                            color: AppColors.white,
                            fontFamily: Strings.EXO_FONT,
                            fontStyle: FontStyle.italic,
                            fontSize: Dimens.twentySix,
                            letterSpacing: .75,
                            fontWeight: FontWeight.w900),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  Images.ICON_CALENDAR,
                                ),
                                SizedBox(
                                  width: Dimens.seven,
                                ),
                                Text(
                                  trainings.nameEN != null
                                      ? 'Training ${trainings.trainingNumber}'
                                      : "",
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: Dimens.forteen,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: Strings.EXO_FONT),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  Images.ICON_TIMER,
                                ),
                                SizedBox(
                                  width: Dimens.seven,
                                ),
                                Text(
                                  '${trainings.workoutTime}',
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: Dimens.forteen,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: Strings.EXO_FONT),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: Dimens.ten,
        ),
      ],
    );
  }

  List<MotivationHistoryItem> _calanderData(
      List<WorkoutActivities> _workoutActivitiesList) {
    List<MotivationHistoryItem> _list = new List();

    for (int i = 0; i < _workoutActivitiesList.length; i++) {
      debugPrint("date   :        ${_workoutActivitiesList[i].createdOnStr}");

      _list.add(MotivationHistoryItem(
          date: Utils.getMonthFromDate(_workoutActivitiesList[i].createdOnStr),
          weekDay:
              Utils.getMonthFromDay(_workoutActivitiesList[i].createdOnStr),
          title: _workoutActivitiesList[i].workoutName,
          isSelected:
              Utils.checkCurrentDate(_workoutActivitiesList[i].createdOnStr)));
      debugPrint(
          'date  :   ${_list[i].date}   week  :   ${_list[i].weekDay}   name:   ${_list[i].title}    isselected:   ${_list[i].isSelected}');
    }
    return _list;
  }
}
