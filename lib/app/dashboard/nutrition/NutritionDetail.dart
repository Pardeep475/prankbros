import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/BackgroundWidgetWithImage.dart';
import 'package:prankbros2/app/dashboard/motivation/Motivation.dart';
import 'package:prankbros2/app/dashboard/profile/Profile.dart';
import 'package:prankbros2/app/dashboard/workouts/Workouts.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';

import 'Nutrition.dart';

class NutritionDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NutritionDetail();
}

class _NutritionDetail extends State<NutritionDetail> {
  int _selectedIndex = 2;
  int _buttonClick = 0;
  bool _isItemClick = false;
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
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat');
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

  void _onItemTapped(int index) {
    _isItemClick = true;
    setState(() {
      _selectedIndex = index;
    });
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

  Widget _callPages(int index) {
    switch (index) {
      case 0:
        {
          return Workouts();
        }
        break;
      case 1:
        {
          return Motivation();
        }
        break;
      case 2:
        {
          return Nutrition();
        }
        break;
      case 3:
        {
          return Profile();
        }
        break;
      default:
        {
          return Workouts();
        }
        break;
    }
  }

  Widget _nutritionDetailWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 40,
        ),
        Container(
          margin: EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(90)),
          ),
          child: Image.asset(
            Images.ArrowBackWhite,
            color: AppColors.black,
            fit: BoxFit.none,
            width: 35.0,
            height: 35.0,
          ),
        ),
        SizedBox(
          height: 240,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 25,
            ),
            Expanded(
              child: Text(
                'Green peas with Basmati Pilaf',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: Dimens.TWENTY_SIX,
                    fontFamily: Strings.EXO_FONT),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
                onTap: _onLikeClicked,
                child: Image.asset(_likeClick ? Images.ICON_LIKE_ACTIVE : Images.ICON_LIKE_INACTIVE)),
            SizedBox(
              width: 25,
            ),
          ],
        ),
        SizedBox(
          height: 33,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 25,
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
              width: 10,
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
                    fontSize: Dimens.THRTEEN,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.04),
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
        Container(
          margin: EdgeInsets.symmetric(horizontal: Dimens.TWENTY_FIVE),
          color: AppColors.light_gray,
          height: 1,
        ),
        Expanded(
          child: ListView.builder(
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
                _methodList[index],
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

  Widget _ingredientsItemBuilder(BuildContext ctxt, int index) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: 25,
            ),
            Container(
              height: 3,
              width: 3,
              decoration: BoxDecoration(
                color: AppColors.nutritionBackColor,
                borderRadius: BorderRadius.all(Radius.circular(90)),
              ),
            ),
            SizedBox(
              width: 21,
            ),
            Expanded(
              child: Text(
                _ingredientsList[index],
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
          height: 10,
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
          body: _isItemClick
              ? _callPages(_selectedIndex)
              : _nutritionDetailWidget(),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 10,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(Images.IconWorkouts)),
                title: Text(
                  '',
                ),
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(Images.IconMotivation)),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(Images.IconNutrition)),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(Images.IconWorkouts)),
                title: Text(''),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: AppColors.pink,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: _onItemTapped,
          ),
        )
      ],
    );
  }
}
