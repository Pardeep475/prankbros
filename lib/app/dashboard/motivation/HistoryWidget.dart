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
import 'package:prankbros2/utils/Utils.dart';

class HistoryWidget extends StatefulWidget {
  final MotivationApiResponse motivationData;

  HistoryWidget({this.motivationData});

  @override
  State<StatefulWidget> createState() =>
      _HistoryWidgetState(motivationData: this.motivationData);
}

class _HistoryWidgetState extends State<HistoryWidget> {
  final MotivationApiResponse motivationData;

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
//        getMotivation();
      }
    });
  }

//  void getMotivation() {
//    if (userId == null || userId.isEmpty) {
//      Utils.showSnackBar('Something went wrong.', context);
//      return;
//    }
//    Utils.checkConnectivity().then((value) {
//      if (value) {
//        _historyBloc.getMotivationActivation(userId, '1', context);
//      } else {
//        Navigator.pop(context);
//        Utils.showSnackBar(
//            Strings.please_check_your_internet_connection, context);
//      }
//    });
//  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration(milliseconds: 60), (){
      _historyBloc.getMotivationActivationStart(motivationData, context);
    });
  }

  void _motivationHistoryListInit() {
    _motivationHistoryList.add(MotivationHistoryItem(
        date: '01', weekDay: 'MO', title: '', isSelected: false));
    _motivationHistoryList.add(MotivationHistoryItem(
        date: '02', weekDay: 'DI', title: '', isSelected: false));
    _motivationHistoryList.add(MotivationHistoryItem(
        date: '03', weekDay: 'MI', title: 'Abs & Arms', isSelected: true));
    _motivationHistoryList.add(MotivationHistoryItem(
        date: '04', weekDay: 'DO', title: '', isSelected: false));
    _motivationHistoryList.add(MotivationHistoryItem(
        date: '05', weekDay: 'FR', title: '', isSelected: false));
    _motivationHistoryList.add(MotivationHistoryItem(
        date: '06', weekDay: 'SA', title: '', isSelected: false));
    _motivationHistoryList.add(MotivationHistoryItem(
        date: '07', weekDay: 'SO', title: '', isSelected: false));
  }

  @override
  Widget build(BuildContext context) {

    return _historyWidget();
  }

  Widget _historyWidget() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.only(top: Dimens.sixty),
        ),
        SliverToBoxAdapter(
          child: _headerWidget(),
        ),
        StreamBuilder<int>(
            initialData: 0,
            stream: _historyBloc.progressStream,
            builder: (context, snapshot) {
              if (snapshot.data == 0) {
                return _progressBarData();
              } else if (snapshot.data == 1) {
                return StreamBuilder<List<MotivationHistoryItem>>(
                    stream: _historyBloc.weightStream,
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            if (snapshot.data[index].isSelected) {
                              return _selectedListItem(
                                  snapshot.data[index], index);
                            } else {
                              return _unSelectedListItem(
                                  snapshot.data[index], index);
                            }
                          }, childCount: snapshot.data.length),
                        );
                      } else {
                        return _errorData();
                      }
                    });
              } else {
                return _errorData();
              }
            }),
      ],
    );
  }

  Widget _errorData() {
    return SliverFillRemaining(
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

  Widget _progressBarData() {
    return SliverFillRemaining(
        child: Center(child: CommonProgressIndicator(true)));
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
                            '01-07 aug 2019',
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
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => CustomChangeWeekDialog());
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
}
