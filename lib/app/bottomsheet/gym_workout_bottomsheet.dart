import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/popups/CustomListPopUp.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';

class GymWorkoutBottomSheet extends StatelessWidget {
  ScrollController myscrollController;
  List<String> contentList;

  GymWorkoutBottomSheet({this.myscrollController, this.contentList});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [AppColors.pink, AppColors.blue],
        begin: Alignment.bottomLeft,
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 37,
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'KG',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: Strings.EXO_FONT,
                      color: Colors.white,
                      fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'WIEDERHOLEN',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: Strings.EXO_FONT,
                          color: Colors.white,
                          fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  )),
              Expanded(
                flex: 3,
                child: Align(
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
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            color: Colors.white,
          ),
          Expanded(
            child: ListView.builder(
              controller: myscrollController,
              itemCount: 10,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 37,
                        ),
                        Expanded(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: Strings.EXO_FONT,
                                color: Colors.white,
                                fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '0',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: Strings.EXO_FONT,
                                color: Colors.white,
                                fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '10 mal',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: Strings.EXO_FONT,
                                color: Colors.white,
                                fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.check_box_outline_blank,
                              color: Colors.white,size: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'last\n\_',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: Strings.EXO_FONT,
                                color: Colors.white,
                                fontSize: 14),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        SizedBox(
                          width: 37,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            color: Colors.white,
                            height: 1,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 3),
                            child: Text(
                              '60 seek',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: Strings.EXO_FONT,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 11),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.white,
                            height: 1,
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
