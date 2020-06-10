import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/nutrition/NutritionDetail.dart';
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
//  List<NutritionTitleModel> titleList = new List();

  _NutritionState({this.onPush});

  final ValueChanged<int> onPush;

  List<NutritionRecipeModel> recipeList = new List();

//
  @override
  void initState() {
    print('init state');
    super.initState();
  }

//
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
//    this.getTitleList(0);
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
    return DefaultTabController(
      length: 4, // Added
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height),
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  Images.TopBg,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: Dimens.SIXTY,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(
                          left: Dimens.EIGHTEEN, right: Dimens.EIGHTEEN),
                      child: Text(
                        'Nutrition',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: AppColors.white,
                            fontFamily: Strings.EXO_FONT,
                            fontWeight: FontWeight.w700,
                            fontSize: Dimens.TWENTY_SEVEN),
                      ),
                    ),
                    SizedBox(
                      height: Dimens.TWENTY_FIVE,
                    ),
                    Divider(
                      color: AppColors.light_gray,
                    ),
                    SizedBox(
                      height: Dimens.TWENTY_FIVE,
                    ),
                    TabBar(
                      isScrollable: true,
                      unselectedLabelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: AppColors.pink,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimens.FIFTY),
                          border: Border.all(
                              color: AppColors.pink_stroke, width: Dimens.ONE)),
                      tabs: <Widget>[
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(AppLocalizations.of(context)
                                .translate(Strings.Alle)),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(AppLocalizations.of(context)
                                .translate(Strings.MixedDiet)),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(AppLocalizations.of(context)
                                .translate(Strings.Vegetarian)),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(AppLocalizations.of(context)
                                .translate(Strings.Favorites)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimens.FORTY,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: <Widget>[
                          _motivationWidget(),
                          _motivationWidget(),
                          _motivationWidget(),
                          _motivationWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _motivationWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimens.TWENTY),
      child: GridView.builder(
        padding: EdgeInsets.only(top: Dimens.TEN),
        itemBuilder: (context, position) {
          return _verticalGridView(position);
        },
        itemCount: recipeList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        shrinkWrap: true,
        // todo comment this out and check the result
        physics: ClampingScrollPhysics(),
      ),
    );
  }

  void _OnItemClick() {
//    Navigator.push(
//        context, MaterialPageRoute(builder: (context) => NutritionDetail()));
    onPush(0);
  }

  Widget _verticalGridView(int index) {
    return InkWell(
      onTap: () => _OnItemClick(),
      child: Container(
        child: Card(
          margin: EdgeInsets.all(Dimens.SEVEN),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.FIFTEEN),
          ),
          elevation: Dimens.FIVE,
          child: Column(
            children: <Widget>[
              ClipRRect(
//              topLeft: Dimens.FIFTEEN,topRight: Dimens.FIFTEEN
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimens.FIFTEEN),
                    topRight: Radius.circular(Dimens.FIFTEEN)),
                child: Image.asset(
                  Images.DummyFood,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: Dimens.ONE_ONE_FOUR,
                ),
              ),
              SizedBox(
                height: Dimens.FIFTEEN,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Dimens.TWENTY),
                alignment: Alignment.topLeft,
                height: Dimens.THIRTY_EIGHT,
                child: Text(
                  recipeList[index].title,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: Dimens.SIXTEEN,
                      color: AppColors.black_text,
                      fontFamily: Strings.EXO_FONT,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: Dimens.TWENTY,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Dimens.TWENTY),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            '927 kcal',
                            style: TextStyle(
                                fontSize: Dimens.ELEVEN,
                                fontFamily: Strings.EXO_FONT,
                                color: AppColors.black_text,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          child: Text(
                            'Energie',
                            style: TextStyle(
                                fontSize: Dimens.EIGHT,
                                fontFamily: Strings.EXO_FONT,
                                color: AppColors.light_text,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: Dimens.TEN),
                      child: Container(
                        height: Dimens.TWENTY_FIVE,
                        width: Dimens.ONE,
                        color: AppColors.light_gray,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            '15 min',
                            style: TextStyle(
                                fontSize: Dimens.ELEVEN,
                                fontFamily: Strings.EXO_FONT,
                                color: AppColors.black_text,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          child: Text(
                            'Time',
                            style: TextStyle(
                                fontSize: Dimens.EIGHT,
                                fontFamily: Strings.EXO_FONT,
                                color: AppColors.light_text,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
