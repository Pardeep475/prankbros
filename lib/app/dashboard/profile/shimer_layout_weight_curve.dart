import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:shimmer/shimmer.dart';

class WeightCurveShimerLaout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .57,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Card(
        elevation: Dimens.THREE,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.ten),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (BuildContext context, int pos) {
            return Column(
              children: <Widget>[
                Shimmer.fromColors(
                  baseColor: Colors.grey[400],
                  highlightColor: Colors.white,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 60,
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 60,
                    ),
                  ),
                ),
                Divider(height: Dimens.ONE, color: AppColors.divider_color)
              ],
            );
          }),
        ),
      ),
    );
  }
}
