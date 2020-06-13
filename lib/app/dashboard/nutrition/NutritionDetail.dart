import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/customviews/BackgroundWidgetWithImage.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';

class NutritionDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NutritionDetail();
}

class _NutritionDetail extends State<NutritionDetail> {
  int _buttonClick = 0;
  bool _likeClick = false;
  List<String> _methodList = new List<String>();
  List<String> _ingredientsList = new List<String>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _methodListInit();
    _ingredientsListInit();
  }

  void _methodListInit() {
    for (int i = 0; i < 10; i++) {
      _methodList.add(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.');
    }
  }

  void _ingredientsListInit() {
    _ingredientsList.add('2 tablespoons ghee or vegetable oil');
    _ingredientsList.add('4 to 5 whole cloves');
    _ingredientsList.add('1-inch stick cinnamon');
    _ingredientsList.add('4 to 5 small green chillies, slit lengthwise');
    _ingredientsList.add('2 medium onions sliced thin (about 2 cups)');
    _ingredientsList.add('2 cups basmati rice');
  }

  void _onButtonClick(int index) {
    setState(() {
      _buttonClick = index;
    });
  }

  void _onLikeClicked() {
    setState(() {
      _likeClick = _likeClick ? false : true;
    });
  }

  void _onBackPressed() {
//    Navigator.pop(context);
    getRootNavigator(context).maybePop();
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

  Widget _nutritionDetailWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: Dimens.forty,
        ),
        GestureDetector(
          onTap: _onBackPressed,
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
              width: Dimens.thirtyFive,
              height: Dimens.thirtyFive,
            ),
          ),
        ),
        SizedBox(
          height: 210,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: Dimens.twentyFive,
            ),
            Expanded(
              child: Text(
                'Green peas with Basmati Pilaf',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: Dimens.twentySix,
                    color: AppColors.black_text,
                    fontFamily: Strings.EXO_FONT),
              ),
            ),
            SizedBox(
              width: Dimens.twenty,
            ),
            GestureDetector(
                onTap: _onLikeClicked,
                child: Image.asset(_likeClick
                    ? Images.ICON_LIKE_ACTIVE
                    : Images.ICON_LIKE_INACTIVE)),
            SizedBox(
              width: Dimens.twentyFive,
            ),
          ],
        ),
        SizedBox(
          height: Dimens.thirtyThree,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: Dimens.twentyFive,
            ),
            GestureDetector(
              onTap: () {
                _onButtonClick(0);
              },
              child: Text(
                'METHOD',
                style: TextStyle(
                    fontFamily: Strings.EXO_FONT,
                    color: _buttonClick == 0
                        ? AppColors.pink_stroke
                        : AppColors.light_text,
                    fontSize: Dimens.THRTEEN,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.04),
              ),
            ),
            SizedBox(
              width: Dimens.ten,
            ),
            GestureDetector(
              onTap: () {
                _onButtonClick(1);
              },
              child: Text(
                'Ingredients'.toUpperCase(),
                style: TextStyle(
                    fontFamily: Strings.EXO_FONT,
                    color: _buttonClick == 1
                        ? AppColors.pink_stroke
                        : AppColors.light_text,
                    fontSize: Dimens.thrteen,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.04),
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
        Container(
          margin: EdgeInsets.symmetric(horizontal: Dimens.twentyFive),
          color: AppColors.divider_color,
          height: 1,
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: Dimens.twenty),
            shrinkWrap: true,
            itemCount: _buttonClick == 0
                ? _methodList.length
                : _ingredientsList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              if (_buttonClick == 0) {
                return _methodItemBuilder(ctxt, index);
              } else {
                return _ingredientsItemBuilder(ctxt, index);
              }
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

  Widget _ingredientsItemBuilder(BuildContext ctxt, int index) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: Dimens.twentyFive,
            ),
            Container(
              height: Dimens.three,
              width: Dimens.three,
              decoration: BoxDecoration(
                color: AppColors.nutritionBackColor,
                borderRadius: BorderRadius.all(Radius.circular(Dimens.ninety)),
              ),
            ),
            SizedBox(
              width: Dimens.twentyOne,
            ),
            Expanded(
              child: Text(
                _ingredientsList[index],
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: Dimens.forteen,
                    fontFamily: Strings.EXO_FONT,
                    color: AppColors.light_text),
              ),
            ),
            SizedBox(
              width: Dimens.twentyOne,
            ),
          ],
        ),
        SizedBox(
          height: Dimens.ten,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        BackgroundWidgetWithImage(
          imagePath: Images.DummyFood,
          curveColor: AppColors.white,
        ),
        Scaffold(
          backgroundColor: AppColors.transparent,
          body: _nutritionDetailWidget(),
        )
      ],
    );
  }
}
