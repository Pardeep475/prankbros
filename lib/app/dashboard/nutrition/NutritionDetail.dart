import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/customviews/BackgroundWidgetWithImage.dart';
import 'package:prankbros2/models/nutrition/NutritionsApiResponse.dart';
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
    super.initState();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
    Navigator.pop(context);

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

  Widget _nutritionDetailWidget(AllNutritions args) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: Dimens.ten,
        ),
        InkWell(
          onTap: _onBackPressed,
          child: Container(
            width: Dimens.FORTY_FIVE,
            height: Dimens.FORTY_FIVE,
            margin:
            EdgeInsets.only(top: Dimens.FIFTY, left: Dimens.TWENTY),
            child: Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                color: AppColors.light_gray,
                borderRadius:
                BorderRadius.all(Radius.circular(Dimens.THIRTY)),
              ),
              child: Center(
                  child: Image.asset(Images.ArrowBackWhite,
                      height: Dimens.fifteen,
                      width: Dimens.twenty,
                      color: AppColors.black)),
            ),
          ),
        ),
        SizedBox(
          height: Dimens.twoHundredForteen,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: Dimens.twentyFive,
            ),
            Expanded(
              child: Text(
                args.nameDE != null ? args.nameDE : '',
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
                    fontSize: Dimens.fifteen,
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
                    fontSize: Dimens.fifteen,
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
            padding: EdgeInsets.only(top: Dimens.thirty),
            shrinkWrap: true,
            itemCount: _buttonClick == 0
                ? args.steps != null ? args.steps.length : 0
                : args.ingredients != null ? args.ingredients.length : 0,
            itemBuilder: (BuildContext ctxt, int index) {
              if (_buttonClick == 0) {
                return _methodItemBuilder(ctxt, index,args.steps[index]);
              } else {
                return _ingredientsItemBuilder(ctxt, index,args.ingredients[index]);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _methodItemBuilder(BuildContext ctxt, int index,Steps steps) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: Dimens.twentyFive,
            ),
            Container(
              height: Dimens.forty,
              width: Dimens.forty,
              decoration: BoxDecoration(
                color: AppColors.light_gray,
                borderRadius: BorderRadius.all(Radius.circular(Dimens.ninety)),
              ),
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Dimens.seventeen,
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
                steps.itemDE != null ? steps.itemDE : '',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: Dimens.sixteen,
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

  Widget _ingredientsItemBuilder(BuildContext ctxt, int index,Ingredients ingredients) {
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
                ingredients.itemDE != null ? ingredients.itemDE : '',
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
    final AllNutritions args = ModalRoute.of(context).settings.arguments;
    return Stack(
      children: <Widget>[
        BackgroundWidgetWithImage(
          imagePath: Images.DummyFood,
          curveColor: AppColors.white,
        ),
        Scaffold(
          backgroundColor: AppColors.transparent,
          body: _nutritionDetailWidget(args),
        )
      ],
    );
  }
}
