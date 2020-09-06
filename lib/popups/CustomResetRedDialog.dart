import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/commonwidgets/ease_in_widget.dart';
import 'package:prankbros2/customviews/CustomViews.dart';
import 'package:prankbros2/picker/Picker.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Keys.dart';
import 'package:prankbros2/utils/Strings.dart';

class CustomResetRedDialog extends StatefulWidget {
  int endRange;
  CustomResetRedDialog({this.endRange});

  @override
  State<StatefulWidget> createState() =>
      _CustomResetRedDialogState(endRange: endRange);
}

class _CustomResetRedDialogState extends State<CustomResetRedDialog> {
  static const Key resetMyProgramKey = Key(Keys.resetMyProgramKey);
  bool isLoading = false;
  int endRange = 1;

  _CustomResetRedDialogState({this.endRange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimens.TWENTY),
      child: Center(
        child: Card(
          elevation: Dimens.FIVE,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.FORTY),
          ),
          child: Wrap(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      Images.POPUP_RED_BACK,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: Dimens.TWENTY,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: Dimens.TWENTY_FIVE,
                            ),
                            Expanded(
                              child: Text(
                                'Program reset',
                                style: TextStyle(
                                    color: AppColors.black_text,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: Strings.EXO_FONT,
                                    fontSize: Dimens.TWENTY_SIX),
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                              width: 30.0,
                              child: EaseInWidget(
                                onTap: () {
                                  _dismissLanguagePopUp(context);
                                },
                                borderRadius: 30.0,
                                child: Image.asset(
                                  Images.ICON_CROSS,
                                  height: Dimens.THIRTY,
                                  width: Dimens.THIRTY,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Dimens.TWENTY_FIVE,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimens.FIFTY,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimens.TWENTY_FIVE),
                            child: Text(
                              'Did you miss a week?',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: AppColors.black_text,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: Strings.EXO_FONT,
                                  fontSize: Dimens.EIGHTEEN),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimens.TWENTY_FIVE),
                            child: Text(
                              Strings.changeYourCurrentWeek,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: AppColors.light_text,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: Strings.EXO_FONT,
                                  fontSize: Dimens.SIXTEEN),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimens.THIRTY,
                        ),
                        showPickerNumberFormatValue(context),
                        SizedBox(
                          height: Dimens.THIRTY,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Dimens.TWENTY_FIVE),
                          child: _resetMyProgramButton(),
                        ),
                        SizedBox(
                          height: Dimens.TWENTY_FIVE,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _dismissLanguagePopUp(BuildContext context) {
    Navigator.pop(context);
  }

  Widget _resetMyProgramButton() {
    return Builder(
      builder: (context) => CustomRaisedButton(
        key: resetMyProgramKey,
        text: "Reset my program".toUpperCase(),
        backgroundColor: AppColors.pink_stroke,
        height: Dimens.SIXTY,
        width: MediaQuery.of(context).size.width,
        borderRadius: Dimens.THIRTY,
        onPressed: () {
          _resetMyProgramClick(context);
        },
        isGradient: true,
        loading: isLoading,
        textStyle: TextStyle(
          fontSize: Dimens.FORTEEN,
          letterSpacing: 1.12,
          color: AppColors.white,
          fontWeight: FontWeight.w700,
          fontFamily: Strings.EXO_FONT,
        ),
      ),
    );
  }

  void _resetMyProgramClick(BuildContext context) {
    print('clicked   $isLoading');
    setState(() {
      isLoading = isLoading ? false : true;
    });
  }

  Widget showPickerNumberFormatValue(BuildContext context) {
    return Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(
            begin: 1,
            end: endRange,
          )
        ]),
        columnPadding: EdgeInsets.symmetric(horizontal: Dimens.TWENTY_FIVE),
        selectedTextStyle: TextStyle(
            color: AppColors.black_text,
            fontFamily: Strings.EXO_FONT,
            letterSpacing: 1.44,
            fontWeight: FontWeight.w700,
            fontSize: Dimens.EIGHTEEN),
        textStyle: TextStyle(
            color: AppColors.light_text,
            fontFamily: Strings.EXO_FONT,
            letterSpacing: 1.44,
            fontWeight: FontWeight.w700,
            fontSize: Dimens.EIGHTEEN),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
        },
        onSelect: (Picker picker, int index, List<int> selecteds) {
          print(selecteds.toString());
          print(picker.getSelectedValues());
        }).makePicker();
  }
}
