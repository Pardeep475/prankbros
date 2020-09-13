import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/motivation/HistoryBloc.dart';
import 'package:prankbros2/customviews/CommonProgressIndicator.dart';
import 'package:prankbros2/models/MotivationHistoryModel.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/models/motivation/MotivationApiResponse.dart';
import 'package:prankbros2/popups/CustomChangeWeekDialog.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/Strings.dart';

class HistoryWidget extends StatefulWidget {
  final MotivationApiResponse motivationData;

  HistoryWidget({this.motivationData});

  @override
  State<StatefulWidget> createState() =>
      _HistoryWidgetState(motivationData: this.motivationData);
}

class _HistoryWidgetState extends State<HistoryWidget> {
  final MotivationApiResponse motivationData;
  String accessToken = '';

  _HistoryWidgetState({this.motivationData});

  List<MotivationHistoryItem> _motivationHistoryList = new List();

  HistoryBloc _historyBloc;
  SessionManager _sessionManager;
  String userId = '';

  @override
  void initState() {
    super.initState();
    _historyBloc = new HistoryBloc();
    _sessionManager = new SessionManager();
    _sessionManager.getUserModel().then((value) {
      debugPrint("userdata   :        $value");
      if (value != null) {
        UserDetails userData = UserDetails.fromJson(value);
        debugPrint('userdata:   :-  ${userData.id}     ${userData.email}');
        userId = userData.id.toString();
        accessToken = userData.accessToken;
//        getMotivation();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration(milliseconds: 100), () {
      _historyBloc.getMotivationActivationStart(motivationData, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _historyWidget();
  }

  Widget _historyWidget() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: Dimens.sixty),
          child: _headerWidget(),
        ),
        Expanded(
          child: StreamBuilder<int>(
              initialData: 0,
              stream: _historyBloc.progressStream,
              builder: (context, snapshot) {
                if (snapshot.data == 0) {
                  return _progressBarData();
                } else if (snapshot.data == 1) {
                  return StreamBuilder<List<MotivationHistoryItem>>(
                      stream: _historyBloc.weightStream,
                      initialData: _historyBloc.Weightlist,
                      builder: (context, snapshot) {
                        print("DataList${snapshot.data}");
                        if (_historyBloc.Weightlist != null) {
                          return ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              if (_historyBloc.Weightlist[index].isSelected) {
                                return _selectedListItem(
                                    _historyBloc.Weightlist[index], index);
                              } else {
                                return _unSelectedListItem(
                                    _historyBloc.Weightlist[index], index);
                              }
                            },
                            itemCount: snapshot.data.length,
                          );
                        } else {
                          return _errorData();
                        }
                      });
                } else {
                  return _errorData();
                }
              }),
        ),
        SizedBox(
          height: Dimens.ten,
        )
      ],
    );
  }

  Widget _errorData() {
    return Center(
      child: Text(
        'No data found',
        style: TextStyle(
            color: AppColors.black_text,
            fontFamily: Strings.EXO_FONT,
            fontWeight: FontWeight.w700,
            fontSize: Dimens.thirty),
      ),
    );
  }

  Widget _progressBarData() {
    return Center(child: CommonProgressIndicator(true));
  }

  Widget _headerWidget() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: Dimens.thirty,
            ),
            Image.asset(
              Images.ICON_DUMBBELL_INACTIVE,
              height: Dimens.fortyFive,
              width: Dimens.fortyFive,
              color: AppColors.light_text,
            ),
            SizedBox(
              width: Dimens.twenty,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Workout activity',
                    style: TextStyle(
                        fontSize: Dimens.twenty,
                        fontFamily: Strings.EXO_FONT,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black_text),
                  ),
                  SizedBox(
                    height: Dimens.eight,
                  ),
                  Material(
                    color: AppColors.transparent,
                    child: InkWell(
                      onTap: () {
                        _openChangeWeekDialog();
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            _weekNameList(pos: 0),
                            style: TextStyle(
                                fontSize: Dimens.sixteen,
                                fontFamily: Strings.EXO_FONT,
                                fontWeight: FontWeight.w500,
                                color: AppColors.light_text),
                          ),
                          SizedBox(
                            width: Dimens.fifteen,
                          ),
                          Image.asset(
                            Images.ICON_DOWN_ARROW,
                            height: Dimens.sixteen,
                            width: Dimens.sixteen,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Dimens.thirty,
            ),
          ],
        ),
        SizedBox(
          height: Dimens.twenty,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.twentyFive),
          child: Divider(
            color: AppColors.divider_color,
            height: Dimens.one,
          ),
        ),
      ],
    );
  }

  void _openChangeWeekDialog() {
    if (motivationData == null) return;

    if (motivationData.weekNameList == null) return;

    if (motivationData.weekNameList.length <= 1) return;

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => CustomChangeWeekDialog(
              list: motivationData.weekNameList,
            )).then((value) {
      debugPrint('back value is ----> $value');
      if (value != null) {

        _weekNameList(pos: value);
        setState(() {});

        _historyBloc.getMotivationActivation(
            userId: userId,
            trainingWeek: value.toString(),
            accessToken: accessToken,
            context: context);
      }
    });
  }

  Widget _selectedListItem(
      MotivationHistoryItem motivationHistoryItem, int index) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimens.ONE_ONE_SEVEN),
                      bottomRight: Radius.circular(Dimens.ONE_ONE_SEVEN)),
                  gradient: LinearGradient(
                    colors: [AppColors.blue, AppColors.pink],
                    begin: Alignment.bottomLeft,
                  )),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: Dimens.thirtySix,
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: Dimens.fifteen,
                      ),
                      Text(
                        motivationHistoryItem.date,
                        style: TextStyle(
                            fontSize: Dimens.twenty,
                            fontFamily: Strings.EXO_FONT,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white),
                      ),
                      SizedBox(
                        height: Dimens.five,
                      ),
                      Text(
                        motivationHistoryItem.weekDay,
                        style: TextStyle(
                            fontSize: Dimens.twelve,
                            fontFamily: Strings.EXO_FONT,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.79,
                            color: AppColors.white),
                      ),
                      SizedBox(
                        height: Dimens.fifteen,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: Dimens.fifteen,
                  ),
                  Container(
                    height: Dimens.eight,
                    width: Dimens.eight,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(Dimens.twenty),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Dimens.twentyFive,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Dimens.thrteen,
            ),
            Expanded(
              child: motivationHistoryItem.title != null
                  ? Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimens.twentyFive,
                          vertical: Dimens.fifteen),
                      decoration: BoxDecoration(
                        color: AppColors.light_gray,
                        borderRadius:
                            BorderRadius.all(Radius.circular(Dimens.hundred)),
                      ),
                      child: Text(
                        motivationHistoryItem.title,
                        style: TextStyle(
                            fontSize: Dimens.eighteen,
                            fontFamily: Strings.EXO_FONT,
                            fontWeight: FontWeight.w700,
                            color: AppColors.light_text),
                      ),
                    )
                  : SizedBox(
                      height: 0,
                      width: 0,
                    ),
            ),
            SizedBox(
              width: Dimens.thirtySix,
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.twentyFive),
          child: Divider(
            color: index == _motivationHistoryList.length - 1
                ? AppColors.white
                : AppColors.divider_color,
            height: Dimens.one,
          ),
        ),
      ],
    );
  }

  Widget _unSelectedListItem(
      MotivationHistoryItem motivationHistoryItem, int index) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: motivationHistoryItem.isSelected
                  ? BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimens.ONE_ONE_SEVEN),
                          bottomRight: Radius.circular(Dimens.ONE_ONE_SEVEN)),
                      gradient: LinearGradient(
                        colors: [AppColors.blue, AppColors.pink],
                        begin: Alignment.bottomLeft,
                      ))
                  : BoxDecoration(),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: Dimens.thirtySix,
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: Dimens.fifteen,
                      ),
                      Text(
                        motivationHistoryItem.date,
                        style: TextStyle(
                            fontSize: Dimens.twenty,
                            fontFamily: Strings.EXO_FONT,
                            fontWeight: FontWeight.w700,
                            color: motivationHistoryItem.isSelected
                                ? AppColors.white
                                : AppColors.black_text),
                      ),
                      SizedBox(
                        height: Dimens.five,
                      ),
                      Text(
                        motivationHistoryItem.weekDay.toUpperCase(),
                        style: TextStyle(
                            fontSize: Dimens.twelve,
                            fontFamily: Strings.EXO_FONT,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.79,
                            color: motivationHistoryItem.isSelected
                                ? AppColors.white
                                : AppColors.black_text),
                      ),
                      SizedBox(
                        height: Dimens.fifteen,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: Dimens.fifteen,
                  ),
                  Container(
                    height: Dimens.eight,
                    width: Dimens.eight,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(Dimens.twenty),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Dimens.twentyFive,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Dimens.thrteen,
            ),
            Expanded(
              child: motivationHistoryItem.title != null
                  ? Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimens.twentyFive,
                          vertical: Dimens.fifteen),
                      decoration: BoxDecoration(
                        color: AppColors.light_gray,
                        borderRadius:
                            BorderRadius.all(Radius.circular(Dimens.hundred)),
                      ),
                      child: Text(
                        motivationHistoryItem.title,
                        style: TextStyle(
                            fontSize: Dimens.eighteen,
                            fontFamily: Strings.EXO_FONT,
                            fontWeight: FontWeight.w700,
                            color: AppColors.light_text),
                      ),
                    )
                  : SizedBox(
                      height: 0,
                      width: 0,
                    ),
            ),
            SizedBox(
              width: Dimens.thirtySix,
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.twentyFive),
          child: Divider(
            color: index == _motivationHistoryList.length - 1
                ? AppColors.white
                : AppColors.divider_color,
            height: Dimens.one,
          ),
        ),
      ],
    );
  }

  String _weekNameList({int pos}) {
    debugPrint('posissomething--->$pos');
    if (motivationData == null) return "";

    if (motivationData.weekNameList == null) return "";

    if (motivationData.weekNameList.length < pos) return "";

    return motivationData.weekNameList[pos];
  }
}
