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

class CustomChangeWeekDialog extends StatefulWidget {
  List<String> list;

  CustomChangeWeekDialog({this.list});

  @override
  State<StatefulWidget> createState() =>
      _CustomChangeWeekDialogState(list: list);
}

class _CustomChangeWeekDialogState extends State<CustomChangeWeekDialog> {
  static const Key doneChangeWeekKey = Key(Keys.doneChangeWeekKey);
  bool isLoading = false;
  int _seletedItem = 0;
  List<String> list;

  _CustomChangeWeekDialogState({this.list});

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
                      Images.POPUP_GRAY_BACK,
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
                                'Change week',
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
                                rippleColor: AppColors.app_ripple_color,
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
                              'Missed a week?',
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
                              Strings.go_back_a_week,
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
                          child: _doneButton(),
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

  Widget _doneButton() {
    return Builder(
      builder: (context) => CustomRaisedButton(
        key: doneChangeWeekKey,
        text: "DONE",
        backgroundColor: AppColors.pink_stroke,
        height: Dimens.SIXTY,
        width: MediaQuery.of(context).size.width,
        borderRadius: Dimens.THIRTY,
        onPressed: () {
          _changeWeekClick(context);
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

  void _changeWeekClick(BuildContext context) {
    print('clicked   $isLoading');
    setState(() {
      isLoading = isLoading ? false : true;
    });
    print(_seletedItem);
    Navigator.pop<int>(context, _seletedItem);
  }

  Widget showPickerNumberFormatValue(BuildContext context) {
    return Picker(
        adapter: PickerDataAdapter<String>(pickerdata: list),
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
          try {
            print(value.toString());

              _seletedItem = value[0];

            print(_seletedItem);
          } catch (e) {
            debugPrint(e.toString());
          }
        },
        onSelect: (Picker picker, int index, List<int> selecteds) {
          debugPrint('$index  $selecteds');
          try {

              _seletedItem = selecteds[0];

            print(_seletedItem);
          } catch (e) {
            debugPrint(e.toString());
          }
        }).makePicker();
  }
}
