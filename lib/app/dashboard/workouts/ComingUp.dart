import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';

class ComingUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ComingUpState();
}

class _ComingUpState extends State<ComingUp> {
  List<String> _methodList = new List<String>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _methodListInit();
  }

  void _methodListInit() {
    for (int i = 0; i < 10; i++) {
      _methodList.add(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.');
    }
  }

  NavigatorState getRootNavigator(BuildContext context) {
    final NavigatorState state = Navigator.of(context);
    try {
      print('navigator ' + state.toString());
      return getRootNavigator(state.context);
    } catch (e) {
      print('navigator catch   ' + e.toString());
      return state;
    }
  }

  Widget _comingUpWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: Dimens.forty,
        ),
        GestureDetector(
          onTap: () {
            getRootNavigator(context).maybePop();
          },
          child: Container(
            margin: EdgeInsets.only(left: Dimens.fifteen),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(Dimens.ninety)),
            ),
            child: Image.asset(
              Images.ArrowBackWhite,
              color: AppColors.black,
              fit: BoxFit.none,
              width: Dimens.forty,
              height: Dimens.forty,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 4.7,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimens.fifteen),
          width: MediaQuery.of(context).size.width,
          child: Card(
            color: AppColors.white,
            elevation: Dimens.ten,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(Dimens.fifteen)),
            ),
            child: Padding(
              padding: EdgeInsets.all(Dimens.twenty),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Inchworm',
                    style: TextStyle(
                        fontFamily: Strings.EXO_FONT,
                        fontSize: Dimens.twentySix,
                        color: AppColors.black_text,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: Dimens.fifteen,
                  ),
                  Text(
                    'abdominals, clutes, \nhamstrings'.toUpperCase(),
                    style: TextStyle(
                        letterSpacing: 1.04,
                        fontFamily: Strings.EXO_FONT,
                        fontSize: Dimens.thrteen,
                        color: AppColors.light_text,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _methodList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return _methodItemBuilder(ctxt, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _methodItemBuilder(BuildContext ctxt, int index) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: Dimens.twentyFive,
            ),
            Container(
              height: Dimens.thirty,
              width: Dimens.thirty,
              decoration: BoxDecoration(
                color: AppColors.light_gray,
                borderRadius: BorderRadius.all(Radius.circular(Dimens.ninety)),
              ),
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Dimens.forteen,
                      fontFamily: Strings.EXO_FONT,
                      color: AppColors.black_text),
                ),
              ),
            ),
            SizedBox(
              width: Dimens.twentyOne,
            ),
            Expanded(
              child: Text(
                _methodList[index],
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: Dimens.forteen,
                    fontFamily: Strings.EXO_FONT,
                    color: AppColors.light_text),
              ),
            ),
            SizedBox(
              width: Dimens.twentyFive,
            ),
          ],
        ),
        SizedBox(
          height: Dimens.twenty,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Image.asset(
          Images.COMING_UP_BACKGROUND,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 3,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: AppColors.workoutDetail2BackColor,
          ),
        ),
        Scaffold(
          backgroundColor: AppColors.transparent,
          body: _comingUpWidget(),
        ),
      ],
    );
  }
}

