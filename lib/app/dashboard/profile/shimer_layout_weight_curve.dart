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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.ten),
      ),
      child: Card(
        elevation: Dimens.THREE,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.ten),
        ),
        child:  Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          enabled: true,
          child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              primary: false,itemCount: 8,
              itemBuilder: (BuildContext context, int pos) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0,),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 200,
                              height: 12.0,
                              color: Colors.white,
                            ),

                          ],
                        ),
                      ),
                      Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(Dimens.thirty)),
                            color: AppColors.light_gray),
                      ),
                      SizedBox(
                        width: Dimens.TWENTY,
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
