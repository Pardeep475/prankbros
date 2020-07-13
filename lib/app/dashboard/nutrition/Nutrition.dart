import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/nutrition/NutritionBloc.dart';
import 'package:prankbros2/app/dashboard/nutrition/NutritionDetail.dart';
import 'package:prankbros2/customviews/BackgroundWidgetWithColor.dart';
import 'package:prankbros2/models/NutritionRecipeModel.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/models/nutrition/NutritionsApiResponse.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Utils.dart';
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
  NutritionBloc _nutritionBloc;
  SessionManager _sessionManager;
  String userId = '';

  @override
  void initState() {
    super.initState();
    _nutritionBloc = new NutritionBloc();
    _sessionManager = new SessionManager();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sessionManager.getUserModel().then((value) {
      debugPrint("userdata   :        ${value}");
      if (value != null) {
        UserDetails userData = UserDetails.fromJson(value);
        debugPrint('userdata:   :-  ${userData.id}     ${userData.email}');
        userId = userData.id.toString();
        _getNutrition(context);
      }
    });
  }

  void _getNutrition(BuildContext context) {
    Utils.checkConnectivity().then((value) {
      if (value) {
        _nutritionBloc.getNutritions(userId, context);
      } else {
        Utils.showSnackBar(
            Strings.please_check_your_internet_connection, context);
      }
    });
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
                  Container(
                    child: Text(
                      'Nutrition',
                      style: TextStyle(
                          color: AppColors.white,
                          fontFamily: Strings.EXO_FONT,
                          fontWeight: FontWeight.w700,
                          fontSize: Dimens.thirty),
                    ),
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
      child: StreamBuilder<List<AllNutritions>>(
        initialData: null,
          stream: _nutritionBloc.nutritionStream,
          builder: (context, snapshot) {
            if (snapshot != null &&
                snapshot.data != null &&
                snapshot.data.length > 0) {
              debugPrint('value is ----->    ${snapshot.data.length}');
              return TabBarView(
                children: <Widget>[
                  _nutritionWidget(0, snapshot.data),
                  _nutritionWidget(1, snapshot.data),
                  _nutritionWidget(2, snapshot.data),
                  _nutritionWidget(3, snapshot.data),
                ],
              );
            } else {
              debugPrint('value is ----->    else');
              return TabBarView(
                children: <Widget>[
                  _errorWidget(),
                  _errorWidget(),
                  _errorWidget(),
                  _errorWidget(),
                ],
              );
            }
          }),
    );
  }

  Widget _errorWidget() {
    return Container(
      child: Center(
        child: Text(
          'No data found',
          style: TextStyle(
              color: AppColors.white,
              fontFamily: Strings.EXO_FONT,
              fontWeight: FontWeight.w700,
              fontSize: Dimens.thirty),
        ),
      ),
    );
  }

  Widget _nutritionWidget(int index, List<AllNutritions> list) {
    List<AllNutritions> _nutritionList = new List();
    for (int i = 0; i < list.length; i++) {
      switch (index) {
        case 0:
          {
            if (list[i].category.compareTo('Mixed_Diet') == 0) {
              _nutritionList.add(list[i]);
            }
          }
          break;
        case 1:
          {
            if (list[i].category.compareTo('Vegetarian') == 0) {
              _nutritionList.add(list[i]);
            }
          }
          break;
        case 2:
          {
            if (list[i].category.compareTo('Mixed_Diet') == 0) {
              _nutritionList.add(list[i]);
            }
          }
          break;
        case 3:
          {
            if (list[i].category.compareTo('Vegetarian') == 0) {
              _nutritionList.add(list[i]);
            }
          }
          break;
      }
    }
    return Container(
      margin: EdgeInsets.only(top: Dimens.sixty),
      child: GridView.builder(
        padding:
            EdgeInsets.only(top: 0, left: 0, right: 0, bottom: Dimens.twenty),
        itemBuilder: (context, position) {
          return _verticalGridView(position, _nutritionList[position]);
        },
        itemCount: _nutritionList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.73,
        ),
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
      ),
    );
  }

  void _OnItemClick(AllNutritions item) {
//    Navigator.push(context, MaterialPageRoute(builder: (context) => NutritionDetail()));
    Navigator.pushNamed(context, Strings.NUTRITION_DETAIL_ROUTE,arguments: item);
//    onPush(0);
  }

  Widget _verticalGridView(int index, AllNutritions item) {
    return InkWell(
      onTap: () => _OnItemClick(item),
      child: Card(
        margin: EdgeInsets.all(Dimens.seven),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.fifteen),
        ),
        elevation: Dimens.five,
        child: Column(
          children: <Widget>[
            FadeInImage(
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: Dimens.ONE_TWO_FIVE,
                image: NetworkImage(item.imagePath),
                placeholder: AssetImage(Images.DummyFood)),
            SizedBox(
              height: Dimens.fifteen,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimens.TWENTY),
              alignment: Alignment.topLeft,
              height: Dimens.thirtyEight,
              child: Text(
                item.nameDE != null ? item.nameDE : '',
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
                        item.energy != null ? item.energy : '',
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
                        item.time != null && item.time.isNotEmpty
                            ? '${item.time} min'
                            : '',
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
