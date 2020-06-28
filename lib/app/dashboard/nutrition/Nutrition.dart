import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/nutrition/NutritionDetail.dart';
import 'package:prankbros2/customviews/BackgroundWidgetWithColor.dart';
import 'package:prankbros2/models/NutritionRecipeModel.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';

class Nutrition extends StatefulWidget {
  Nutrition({this.onPush});

  final ValueChanged<int> onPush;

  @override
  _NutritionState createState() => _NutritionState(onPush: this.onPush);
}

class _NutritionState extends State<Nutrition> {
  _NutritionState({this.onPush});

  final ValueChanged<int> onPush;
  List<NutritionRecipeModel> recipeList = new List();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this._recipeList();
  }

  void _recipeList() {
    for (var i = 0; i < 10; i++) {
      if (i % 2 == 0) {
        recipeList.add(NutritionRecipeModel('Frische Erbsen mit ßasmati Reis',
            '927 kcal', '15min', Images.DummyFood));
      } else {
        recipeList.add(NutritionRecipeModel(
            'Gruner', '927 kcal', '15min', Images.DummyFood));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: BackgroundWidgetWithColor(
              curveColor: AppColors.workoutDetail2BackColor,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: Dimens.eighty,
                left: Dimens.twentyFive,
                right: Dimens.twentyFive),
            child: DefaultTabController(
              length: 4, // Added
              initialIndex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Nutrition',
                    style: TextStyle(
                        color: AppColors.white,
                        fontFamily: Strings.EXO_FONT,
                        fontWeight: FontWeight.w700,
                        fontSize: Dimens.twentySeven),
                  ),
                  SizedBox(
                    height: Dimens.thirtyFive,
                  ),
                  Divider(
                    height: Dimens.one,
                    color: AppColors.divider_color,
                  ),
                  SizedBox(
                    height: Dimens.thirtyFive,
                  ),
                  _tabBarWidget(),
                  _tabBarViewWidget()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBarWidget() {
    return TabBar(
      isScrollable: true,
      unselectedLabelColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppColors.pink,
      indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.FIFTY),
          border: Border.all(color: AppColors.pink_stroke, width: Dimens.ONE)),
      tabs: <Widget>[
        Tab(
          child: Align(
            alignment: Alignment.center,
            child: Text(AppLocalizations.of(context).translate(Strings.Alle)),
          ),
        ),
        Tab(
          child: Align(
            alignment: Alignment.center,
            child:
                Text(AppLocalizations.of(context).translate(Strings.MixedDiet)),
          ),
        ),
        Tab(
          child: Align(
            alignment: Alignment.center,
            child: Text(
                AppLocalizations.of(context).translate(Strings.Vegetarian)),
          ),
        ),
        Tab(
          child: Align(
            alignment: Alignment.center,
            child:
                Text(AppLocalizations.of(context).translate(Strings.Favorites)),
          ),
        ),
      ],
    );
  }

  Widget _tabBarViewWidget() {
    return Expanded(
      child: TabBarView(
        children: <Widget>[
          _nutritionWidget(0),
          _nutritionWidget(1),
          _nutritionWidget(2),
          _nutritionWidget(3),
        ],
      ),
    );
  }

  Widget _nutritionWidget(int index) {
    return Container(
      margin: EdgeInsets.only(top: Dimens.sixty),
      child: GridView.builder(
        padding:
            EdgeInsets.only(top: 0, left: 0, right: 0, bottom: Dimens.twenty),
        itemBuilder: (context, position) {
          return _verticalGridView(position);
        },
        itemCount: recipeList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.73,
        ),
        shrinkWrap: true,
        // todo comment this out and check the result
        physics: ClampingScrollPhysics(),
      ),
    );
  }

  void _OnItemClick() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NutritionDetail()));
//    onPush(0);
  }

  Widget _verticalGridView(int index) {
    return InkWell(
      onTap: () => _OnItemClick(),
      child: Card(
        margin: EdgeInsets.all(Dimens.seven),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.fifteen),
        ),
        elevation: Dimens.five,
        child: Column(
          children: <Widget>[
            Image.asset(
              Images.DummyFood,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: Dimens.ONE_TWO_FIVE,
            ),
            SizedBox(
              height: Dimens.fifteen,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimens.TWENTY),
              alignment: Alignment.topLeft,
              height: Dimens.thirtyEight,
              child: Text(
                recipeList[index].title,
                maxLines: 2,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: Dimens.SIXTEEN,
                    color: AppColors.black_text,
                    fontFamily: Strings.EXO_FONT,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: Dimens.fifteen,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimens.twenty),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '927 kcal',
                        style: TextStyle(
                            fontSize: Dimens.twelve,
                            fontFamily: Strings.EXO_FONT,
                            color: AppColors.black_text,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'Energie',
                        style: TextStyle(
                            fontSize: Dimens.ten,
                            fontFamily: Strings.EXO_FONT,
                            color: AppColors.light_text,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Container(
                    height: Dimens.twentyFive,
                    width: Dimens.one,
                    color: AppColors.divider_color,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '15 min',
                        style: TextStyle(
                            fontSize: Dimens.twelve,
                            fontFamily: Strings.EXO_FONT,
                            color: AppColors.black_text,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'Time',
                        style: TextStyle(
                            fontSize: Dimens.ten,
                            fontFamily: Strings.EXO_FONT,
                            color: AppColors.light_text,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
