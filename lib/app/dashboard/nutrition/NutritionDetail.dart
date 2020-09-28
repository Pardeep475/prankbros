import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/nutrition/NutritionDetailBloc.dart';
import 'package:prankbros2/commonwidgets/ease_in_widget.dart';
import 'package:prankbros2/customviews/BackgroundWidgetWithImage.dart';
import 'package:prankbros2/customviews/CommonProgressIndicator.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/models/nutrition/NutritionActionModel.dart';
import 'package:prankbros2/models/nutrition/NutritionsApiResponse.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Utils.dart';

class NutritionDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NutritionDetail();
}

class _NutritionDetail extends State<NutritionDetail> {
  int _buttonClick = 0;
  bool _likeClick = false;
  bool fav = false;
  NutritionDetailBloc _nutritionDetailBloc;
  SessionManager _sessionManager;
  String userId = '';
  String accessToken = '';

  @override
  void initState() {
    super.initState();
    _nutritionDetailBloc = new NutritionDetailBloc();
    _sessionManager = new SessionManager();

    _sessionManager.getUserModel().then((value) {
      debugPrint("userdata   :        $value");
      if (value != null) {
        UserDetails userData = UserDetails.fromJson(value);
        debugPrint('userdata:   :-  ${userData.id}     ${userData.email}');
        userId = userData.id.toString();
        accessToken = userData.accessToken.toString();
      }
    });
  }

  void _onButtonClick(int index) {
    setState(() {
      _buttonClick = index;
    });
  }

  void _onLikeClicked(int nutritionId, BuildContext context,bool isFav) {
    if (userId != null && userId.isNotEmpty) {
      _nutritionActionModel(
          int.parse(userId), nutritionId, !fav, context);
    } else {
      Utils.showSnackBar('Something went wrong', context);
    }
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

  Widget _nutritionDetailWidget(NutritionData args) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: Dimens.ten,
            ),
            Container(
              width: Dimens.FORTY_FIVE,
              height: Dimens.FORTY_FIVE,
              margin: EdgeInsets.only(top: Dimens.FIFTY, left: Dimens.TWENTY),
              child: Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  color: AppColors.light_gray,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimens.THIRTY)),
                ),
                child: Center(
                    child: EaseInWidget(
                  onTap: _onBackPressed,
                  borderRadius: 30.0,
                  child: Image.asset(Images.ArrowBackWhite,
                      height: Dimens.fifteen,
                      width: Dimens.twenty,
                      color: AppColors.black),
                )),
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
                Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                        onTap: () {
                          fav=args.favorite;
                          fav=!fav;
                          args.favorite=fav;
                          _onLikeClicked(args.id, context,fav);
                        },
                        child: StreamBuilder<bool>(
                            initialData: false,
                            stream: _nutritionDetailBloc.nutritionStream,
                            builder: (context, snapshot) {
                              if(args.favorite!=null&&fav==false)
                                fav=args.favorite;
                              print("IsFav${fav}");
                              if (snapshot.data != null) {
                                if (snapshot.data) {
                                  _likeClick = _likeClick ? false : true;
                                }
                              }
                              return Image.asset(fav
                                  ? Images.ICON_LIKE_ACTIVE
                                  : Images.ICON_LIKE_INACTIVE);
                            }));
                  },
                ),
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
                    return _methodItemBuilder(ctxt, index, args.steps[index]);
                  } else {
                    return _ingredientsItemBuilder(
                        ctxt, index, args.ingredients[index]);
                  }
                },
              ),
            ),
          ],
        ),
        StreamBuilder<bool>(
          initialData: false,
          stream: _nutritionDetailBloc.progressStream,
          builder: (context, snapshot) {
            return Center(
                child: CommonProgressIndicator(snapshot.data ? true : false));
          },
        ),
      ],
    );
  }

  Widget _methodItemBuilder(BuildContext ctxt, int index, Steps steps) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: Dimens.twentyFive,
            ),
            Container(
              height: Dimens.thirtyFive,
              width: Dimens.thirtyFive,
              decoration: BoxDecoration(
                color: AppColors.light_gray,
                borderRadius: BorderRadius.all(Radius.circular(Dimens.ninety)),
              ),
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Dimens.sixteen,
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

  Widget _ingredientsItemBuilder(
      BuildContext ctxt, int index, Ingredients ingredients) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: Dimens.twentyFive,
              ),
              Container(
                height: Dimens.six,
                width: Dimens.six,
                decoration: BoxDecoration(
                  color: AppColors.nutritionBackColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimens.ninety)),
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
                      fontSize: Dimens.sixteen,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final NutritionData args = ModalRoute.of(context).settings.arguments;
    return Stack(
      children: <Widget>[
        BackgroundWidgetWithImage(
          imagePath: args.imagePath,
          curveColor: AppColors.white,
        ),
        Scaffold(
          backgroundColor: AppColors.transparent,
          body: _nutritionDetailWidget(args),
        )
      ],
    );
  }

  void _nutritionActionModel(
      int userId, int nutritionId, bool action, BuildContext context) {
    Utils.checkConnectivity().then((value) {
      if (value) {
        debugPrint(
            'userid----->  $userId   nutritionId----->$nutritionId  nutritionId----->$action');
        _nutritionDetailBloc.nutritionActionModel(
            nutritionActionModel: NutritionActionModel(
                userId: userId, nutritionId: nutritionId, favorite: action),
            accessToken: accessToken,
            context: context);
      } else {
        Utils.showSnackBar(
            Strings.please_check_your_internet_connection, context);
      }
    });
  }
}
