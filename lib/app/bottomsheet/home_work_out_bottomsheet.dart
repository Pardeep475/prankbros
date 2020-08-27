import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/workouts/WarmUpCompleted.dart';
import 'package:prankbros2/popups/CustomListPopUp.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';

class HomeSheetWorkout extends StatelessWidget{
  ScrollController myscrollController;
  List<String> contentList;
  int start;
  VoidCallback playVideo;
  HomeSheetWorkout({this.myscrollController,this.contentList,this.start,this.playVideo});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.pink, AppColors.blue],
              begin: Alignment.bottomLeft,
            )),
        child: SingleChildScrollView(
          controller: myscrollController,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.pink, AppColors.blue],
                  begin: Alignment.bottomLeft,
                )),
            child: Wrap(
              children: <Widget>[
                Column(
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
                              contentList: contentList,
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
                      onTap: (){
                        _completedDetectClick(context);
                      },
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
                      '$start',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: Strings.EXO_FONT,
                          color: AppColors.white,
                          fontSize: Dimens.TWENTY_SIX),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        playVideo();
                      },
                      child: Image.asset(
                        Images.ICON_PLAY,
                        height: 57,
                        width: 57,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }


  void _completedDetectClick(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WarmUpCompleted()));
  }
}