import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/nutrition/NutritionBloc.dart';
import 'package:prankbros2/customviews/BackgroundWidgetWithColor.dart';
import 'package:prankbros2/models/NutritionRecipeModel.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/models/nutrition/NutritionsApiResponse.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Utils.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';
import 'package:shimmer/shimmer.dart';

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
  String accessToken = '';

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
      debugPrint("userdata   :        $value");
      if (value != null) {
        UserDetails userData = UserDetails.fromJson(value);
        debugPrint('userdata:   :-  ${userData.id}     ${userData.email}');
        userId = userData.id.toString();
        accessToken = userData.accessToken.toString();
        _getNutrition(context);
      }
    });
  }

  void _getNutrition(BuildContext context) {
    Utils.checkConnectivity().then((value) {
      if (value) {
        _nutritionBloc.getNutritions(
            userId: userId, context: context, accessToken: accessToken);
      } else {
        Utils.showSnackBar(
            Strings.please_check_your_internet_connection, context);
      }
    });
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
                  StreamBuilder<int>(
                    initialData: 0,
                    stream: _nutritionBloc.progressStream,
                    builder: (context, snapshot) {
                      if (snapshot.data == 0) {
                        return Expanded(
                          child: TabBarView(
                            children: <Widget>[
                              progressWidget(),
                              progressWidget(),
                              progressWidget(),
                              progressWidget(),
                            ],
                          ),
                        );
                      }
                      if (snapshot.data == 1) {
                        return StreamBuilder<NutritionsApiResponse>(
                            initialData: null,
                            stream: _nutritionBloc.nutritionStream,
                            builder: (context, snapshot) {
                              if (snapshot != null && snapshot.data != null) {
                                return _tabBarViewWidget(0, snapshot.data);
                              } else {
                                return _tabBarViewWidget(1, null);
                              }
                            });
                      } else {
                        return Expanded(
                          child: TabBarView(
                            children: <Widget>[
                              _errorWidget(value: 'No data found'),
                              _errorWidget(value: 'No data found'),
                              _errorWidget(value: 'No data found'),
                              _errorWidget(value: 'No data found'),
                            ],
                          ),
                        );
                      }
                    },
                  ),
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

  Widget progressWidget() {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.only(top: 50, bottom: Dimens.twenty),
        itemBuilder: (context, position) {
          return Card(
            margin: EdgeInsets.all(Dimens.seven),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(Dimens.twenty))),
            child: Shimmer.fromColors(
              child: Container(
                height: Dimens.ONE_TWO_FIVE,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
              baseColor: Colors.grey[400],
              highlightColor: Colors.white,
              enabled: true,
            ),
          );
        },
        itemCount: 4,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      ),
    );
  }

  Widget _tabBarViewWidget(int index, NutritionsApiResponse item) {
    debugPrint('------------>${item}');
    return Expanded(
      child: (() {
        if (index == 0) {
          return TabBarView(
            children: <Widget>[
              item.allNutritions != null && item.allNutritions.length > 0
                  ? _nutritionWidget(item.allNutritions)
                  : _errorWidget(value: 'No data found'),
              item.mixNutritions != null && item.mixNutritions.length > 0
                  ? _nutritionWidget(item.mixNutritions)
                  : _errorWidget(value: 'No data found'),
              item.vegNutritions != null && item.vegNutritions.length > 0
                  ? _nutritionWidget(item.vegNutritions)
                  : _errorWidget(value: 'No data found'),
              item.favoriteNutritions != null &&
                      item.favoriteNutritions.length > 0
                  ? _nutritionWidget(item.favoriteNutritions)
                  : _errorWidget(value: 'No data found'),
            ],
          );
        } else if (index == 1) {
          return TabBarView(
            children: <Widget>[
              _errorWidget(),
              _errorWidget(),
              _errorWidget(),
              _errorWidget(),
            ],
          );
        } else {
          return TabBarView(
            children: <Widget>[
              _errorWidget(),
              _errorWidget(),
              _errorWidget(),
              _errorWidget(),
            ],
          );
        }
      }()),
    );
  }

  Widget _errorWidget({String value = ''}) {
    return Container(
      child: Center(
        child: Text(
          value,
          style: TextStyle(
              color: AppColors.black_text,
              fontFamily: Strings.EXO_FONT,
              fontWeight: FontWeight.w700,
              fontSize: Dimens.thirty),
        ),
      ),
    );
  }

  Widget _nutritionWidget(List<NutritionData> list) {
    debugPrint('------------>${list.length}');
    return Container(
      margin: EdgeInsets.only(top: Dimens.sixty),
      child: GridView.builder(
        padding:
            EdgeInsets.only(top: 0, left: 0, right: 0, bottom: Dimens.twenty),
        itemCount: list.length,
        itemBuilder: (context, position) {
          debugPrint('------------>itembuilder   ${position}');
          return _verticalGridView(position, list[position]);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.76,
        ),
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
      ),
    );
  }

  void _onItemClick(NutritionData item) {
//    Navigator.push(context, MaterialPageRoute(builder: (context) => NutritionDetail()));
    Navigator.pushNamed(context, Strings.NUTRITION_DETAIL_ROUTE,
        arguments: item);
//    onPush(0);
  }

  Widget _verticalGridView(int index, NutritionData item) {
    return InkWell(
      onTap: () => _onItemClick(item),
      child: Card(
        margin: EdgeInsets.all(Dimens.seven),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.fifteen),
        ),
        elevation: Dimens.five,
        child: Column(
          children: <Widget>[
            CachedNetworkImage(
              width: MediaQuery.of(context).size.width,
              height: Dimens.ONE_TWO_FIVE,
              imageUrl: item.imagePath,
              imageBuilder: (context, imageProvider) => Container(
                width: MediaQuery.of(context).size.width,
                height: Dimens.ONE_TWO_FIVE,
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) =>
                  Utils.getAssetImage(

                     Dimens.ONE_TWO_FIVE,
                     MediaQuery.of(context).size.width),
              errorWidget: (context, url, error) =>
                  Utils.getImagePlaceHolderWidgetProfile(
                      context: context,
                      height: Dimens.ONE_TWO_FIVE,
                      width: MediaQuery.of(context).size.width),
            ),
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
                        item.energy != null ? '${item.energy} kcal' : '',
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
