import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:shimmer/shimmer.dart';

class WorkOutDetailShimmer extends StatelessWidget {
  String screenName;
  String traingWeek;

  WorkOutDetailShimmer(this.screenName, this.traingWeek);

  @override
  Widget build(BuildContext context) {
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
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
                        '$screenName Workout'.toUpperCase(),
                        style: TextStyle(
                            color: AppColors.white,
                            fontFamily: Strings.EXO_FONT,
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500),
                      ),
                      InkWell(
                        // onTap: _editButtonPressed,
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
                  SizedBox(
                    height: Dimens.twentySix,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: Dimens.twentyFive,
                      ),
                      Text(
                        'Week $traingWeek',
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
                  SizedBox(
                    height: Dimens.forty,
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
                  itemCount: 2,
                  itemBuilder: (context, pos) {
                    return Shimmer.fromColors(
                      child: Container(
                        height: Dimens.oneHundredEightyFive,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        margin: EdgeInsets.only(right: 25, left: 25, top: 15),
                      ),
                      baseColor: Colors.grey[400],
                      highlightColor: Colors.white,
                    );
                  }),
            )
          ],
        ),
      ],
    );
  }
}
