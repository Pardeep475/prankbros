import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/workouts/WarmUpCompleted.dart';
import 'package:prankbros2/app/dashboard/workouts/WorkOutCompleted.dart';
import 'package:prankbros2/popups/CustomListPopUp.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';

class WarmUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WarmUpScreenState();
}

class _WarmUpScreenState extends State<WarmUpScreen> {
  List<String> _contentList = new List<String>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contentListInit();
  }

  void _contentListInit() {
    for (int i = 0; i < 4; i++) {
      _contentList.add(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            Images.GYM_WORK_BACKGROUND,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 35,
            left: 5,
            child: GestureDetector(
              onTap: () => debugPrint('back button pressed'),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Image.asset(
                  Images.ArrowBackWhite,
                  fit: BoxFit.none,
                  width: 35.0,
                  height: 35.0,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Wrap(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [AppColors.pink, AppColors.blue],
                    begin: Alignment.bottomLeft,
                  )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () => showDialog(
                              context: context,
                              builder: (_) => CustomListPopUp(
                                    contentList: _contentList,
                                  )),
                          child: Padding(
                              padding: EdgeInsets.only(right: 37),
                              child: Image.asset(Images.ICON_HELP)),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: _completedDetectClick,
                        child: Text(
                          'Upright cable row',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: Strings.EXO_FONT,
                              color: AppColors.white,
                              fontSize: Dimens.TWENTY_SIX),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Warm-Up',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: Strings.EXO_FONT,
                            color: AppColors.white,
                            fontSize: Dimens.THRTEEN),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          height: 1,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        '00:00:19',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: Strings.EXO_FONT,
                            color: AppColors.white,
                            fontSize: Dimens.TWENTY_SIX),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        Images.ICON_PLAY,
                        height: 57,
                        width: 57,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _completedDetectClick() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WarmUpCompleted()));
  }
}
