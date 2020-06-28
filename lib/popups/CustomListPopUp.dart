import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';

class CustomListPopUp extends StatefulWidget {
  List<String> contentList;

  CustomListPopUp({this.contentList});

  @override
  State<StatefulWidget> createState() =>
      _CustomListPopUp(contentList: this.contentList);
}

class _CustomListPopUp extends State<CustomListPopUp> {
  List<String> contentList;

  _CustomListPopUp({this.contentList});

  Widget _methodItemBuilder(BuildContext ctxt, int index) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: 25,
            ),
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: AppColors.nutritionBackColor,
                borderRadius: BorderRadius.all(Radius.circular(90)),
              ),
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Dimens.FORTEEN,
                      fontFamily: Strings.EXO_FONT,
                      color: AppColors.black_text),
                ),
              ),
            ),
            SizedBox(
              width: 21,
            ),
            Expanded(
              child: Text(
                contentList[index],
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: Dimens.FORTEEN,
                    fontFamily: Strings.EXO_FONT,
                    color: AppColors.light_text),
              ),
            ),
            SizedBox(
              width: 25,
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Center(
        child: Wrap(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Image.asset(Images.ICON_CROSS)),
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Upright cable row'.toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: Dimens.THRTEEN,
                          letterSpacing: 1.04,
                          fontFamily: Strings.EXO_FONT,
                          color: AppColors.black_text),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Wrap(
                    children: <Widget>[
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: contentList.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return _methodItemBuilder(ctxt, index);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
