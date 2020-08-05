import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/motivation/HistoryWidget.dart';
import 'package:prankbros2/app/dashboard/motivation/MotivationBloc.dart';
import 'package:prankbros2/app/dashboard/motivation/MotivationWidget.dart';
import 'package:prankbros2/customviews/BackgroundWidgetWithColor.dart';
import 'package:prankbros2/customviews/CommonProgressIndicator.dart';
import 'package:prankbros2/models/MotivationModel.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/models/motivation/MotivationApiResponse.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Utils.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';

class Motivation extends StatefulWidget {
  @override
  _MotivationState createState() => _MotivationState();
}

class _MotivationState extends State<Motivation> {
  int _tabClickIndex = 0;
  List<MotivationModel> titleList = new List();
  String workout = '0';
  String week = '1';
  String motivation = '1/4';
  SessionManager _sessionManager;
  String userId = '';
  String accessToken = '';
  MotivationBloc _motivationBloc;

  @override
  void initState() {
    super.initState();
    _motivationBloc = new MotivationBloc();
    _sessionManager = new SessionManager();
    _sessionManager.getUserModel().then((value) {
      debugPrint("userdata   :        $value");
      if (value != null) {
        UserDetails userData = UserDetails.fromJson(value);
        debugPrint('userdata:   :-  ${userData.id}     ${userData.email}');
        userId = userData.id.toString();
        accessToken = userData.accessToken;
        getMotivation();
      }
    });
  }

  void getMotivation() {
    if (userId == null || userId.isEmpty) {
      Utils.showSnackBar('Something went wrong.', context);
      return;
    }
    Utils.checkConnectivity().then((value) {
      if (value) {
        _motivationBloc.getMotivation(
            accessToken: accessToken, userId: userId, context: context);
      } else {
        Navigator.pop(context);
        Utils.showSnackBar(
            Strings.please_check_your_internet_connection, context);
      }
    });
  }

  void _tabClick(int index) {
    setState(() {
      _tabClickIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: BackgroundWidgetWithColor(
              curveColor: AppColors.white,
            ),
          ),
          StreamBuilder<int>(
              initialData: 0,
              stream: _motivationBloc.progressStream,
              builder: (context, snapshot) {
                return Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: Dimens.eighty,
                          left: Dimens.twentyFive,
                          right: Dimens.twentyFive),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate(Strings.motivation),
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontFamily: Strings.EXO_FONT,
                                  fontWeight: FontWeight.w700,
                                  fontSize: Dimens.twentySeven),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  _tabClick(0);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: Dimens.twenty),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: _tabClickIndex == 0
                                              ? AppColors.pink_stroke
                                              : AppColors.transparent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Dimens.twenty))),
                                  padding: EdgeInsets.all(Dimens.ten),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate(Strings.motivation),
                                    style: TextStyle(
                                        color: _tabClickIndex == 0
                                            ? AppColors.pink
                                            : AppColors.white,
                                        fontFamily: Strings.EXO_FONT,
                                        fontWeight: FontWeight.w700,
                                        fontSize: Dimens.thrteen),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _tabClick(1);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: Dimens.ten),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: _tabClickIndex == 0
                                              ? AppColors.transparent
                                              : AppColors.pink_stroke),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Dimens.twenty))),
                                  padding: EdgeInsets.all(Dimens.ten),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate(Strings.history),
                                    style: TextStyle(
                                        color: _tabClickIndex == 0
                                            ? AppColors.white
                                            : AppColors.pink,
                                        fontFamily: Strings.EXO_FONT,
                                        fontWeight: FontWeight.w700,
                                        fontSize: Dimens.thrteen),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimens.thirtyFive,
                    ),
                    Divider(
                      height: Dimens.one,
                      color: AppColors.divider_color,
                    ),
                    SizedBox(
                      height: Dimens.thirtyFive,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: Dimens.thirty,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              StreamBuilder<String>(
                                  initialData: '1',
                                  stream: _motivationBloc.workoutStream,
                                  builder: (context, snapshot) {
                                    return Text(
                                      snapshot.data,
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontFamily: Strings.EXO_FONT,
                                          fontWeight: FontWeight.w600,
                                          fontSize: Dimens.eighteen),
                                    );
                                  }),
                              SizedBox(
                                height: Dimens.five,
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate(Strings.workouts),
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontFamily: Strings.EXO_FONT,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Dimens.twelve),
                              ),
                            ],
                          ),
                          Container(
                            color: AppColors.divider_color,
                            height: Dimens.forty,
                            width: Dimens.one,
//                      margin: EdgeInsets.only(top: Dimens.TEN,bottom: Dimens.TEN),
                          ),
                          Column(
                            children: <Widget>[
                              StreamBuilder<String>(
                                  initialData: '1',
                                  stream: _motivationBloc.weekStream,
                                  builder: (context, snapshot) {
                                    return Text(
                                      snapshot.data,
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontFamily: Strings.EXO_FONT,
                                          fontWeight: FontWeight.w600,
                                          fontSize: Dimens.eighteen),
                                    );
                                  }),
                              SizedBox(
                                height: Dimens.five,
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate(Strings.week),
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontFamily: Strings.EXO_FONT,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Dimens.twelve),
                              ),
                            ],
                          ),
                          Container(
                            color: AppColors.divider_color,
                            height: Dimens.forty,
                            width: Dimens.one,
//                      margin: EdgeInsets.only(top: Dimens.TEN,bottom: Dimens.TEN),
                          ),
                          Column(
                            children: <Widget>[
                              StreamBuilder<String>(
                                  initialData: '0/4',
                                  stream: _motivationBloc.motivationStream,
                                  builder: (context, snapshot) {
                                    return Text(
                                      snapshot.data,
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontFamily: Strings.EXO_FONT,
                                          fontWeight: FontWeight.w600,
                                          fontSize: Dimens.eighteen),
                                    );
                                  }),
                              SizedBox(
                                height: Dimens.five,
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate(Strings.motivation),
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontFamily: Strings.EXO_FONT,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Dimens.twelve),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    (() {
                      if (snapshot.data == 0) {
                        // progress dialog
                        return _progressBarData();
                      } else if (snapshot.data == 1) {
                        // data
                        return _contentData();
                      } else if (snapshot.data == 2) {
                        //error
                        return _errorData();
                      } else {
                        // error
                        return _errorData();
                      }
                    }()),
                  ],
                );
              }),
        ],
      ),
    );
  }

  Widget _progressBarData() {
    return Expanded(child: Center(child: CommonProgressIndicator(true)));
  }

  Widget _contentData() {
    return StreamBuilder<MotivationApiResponse>(
        initialData: null,
        stream: _motivationBloc.weightStream,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            _motivationBloc.motivationSink.add(
                snapshot.data.motivationData.motivationalVideos != null
                    ? '${snapshot.data.motivationData.motivationalVideos}/4'
                    : '0/4');
            _motivationBloc.workoutSink.add(
                snapshot.data.motivationData.workouts != null
                    ? snapshot.data.motivationData.workouts.toString()
                    : '0');
            _motivationBloc.weekSink.add(
                snapshot.data.motivationData.week != null
                    ? snapshot.data.motivationData.week.toString()
                    : '1');
            return Expanded(
              child: _tabClickIndex == 0
                  ? MotivationWidget(
                      motivationData: snapshot.data.motivationData,
                    )
                  : HistoryWidget(
                      motivationData: snapshot.data,
                    ),
            );
          } else {
            return SizedBox(
              width: 0,
              height: 0,
            );
          }
        });
  }

  Widget _errorData() {
    return Expanded(
      child: Center(
        child: Text(
          'No data found',
          style: TextStyle(
              color: AppColors.black_text,
              fontFamily: Strings.EXO_FONT,
              fontWeight: FontWeight.w700,
              fontSize: Dimens.thirty),
        ),
      ),
    );
  }
}
