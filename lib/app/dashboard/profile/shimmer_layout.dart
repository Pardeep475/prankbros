import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePictureShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400],
      highlightColor: Colors.white,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.62,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: Dimens.forty,
            ),
            Align(
              alignment: Alignment.center,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    //  _selectImageButton();
                  },
                  borderRadius: BorderRadius.all(Radius.circular(Dimens.fifty)),
                  child: Card(
                    color: AppColors.light_gray,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimens.fifty),
                    ),
                    elevation: Dimens.three,
                    child: Container(
                      height: Dimens.seventyFour,
                      width: Dimens.seventyFour,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(Dimens.fifty)),
                          color: AppColors.light_gray),
                      child: Center(
                        child: Image.asset(
                          Images.ICON_PLUS,
                          height: Dimens.twentyFour,
                          width: Dimens.twentyFour,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dimens.forty,
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[400],
              highlightColor: Colors.white,
              enabled: true,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: SizedBox(
                  height: 35,
                  width: 200,
                  child: Shimmer.fromColors(
                    child: Container(
                      height: 35,
                      width: 200,
                    ),
                    baseColor: Colors.grey[400],
                    highlightColor: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              height: 80,
              child: ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int position) {
                    return Shimmer.fromColors(
                      child: Container(
                        height: 80,
                        width: 80,
                        margin: EdgeInsets.only(top: 0, left: 10),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      baseColor: Colors.grey[400],
                      highlightColor: Colors.white,
                      enabled: true,
                    );
                  }),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[400],
              highlightColor: Colors.white,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: SizedBox(
                    height: 35,
                    width: 200,
                    child: Shimmer.fromColors(
                      child: Container(
                        height: 35,
                        width: 200,
                      ),
                      baseColor: Colors.grey[400],
                      highlightColor: Colors.white,
                    ),
                  )),
            ),
            Container(
              height: 80,
              child: ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int position) {
                    return Shimmer.fromColors(
                      child: Container(
                        height: 80,
                        width: 80,
                        margin: EdgeInsets.only(top: 5, left: 10),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      baseColor: Colors.grey[400],
                      highlightColor: Colors.white,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
