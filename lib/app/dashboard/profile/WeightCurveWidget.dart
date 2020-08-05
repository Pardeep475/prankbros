import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/profile/weightcurve/WeightCurveBloc.dart';
import 'package:prankbros2/customviews/CommonProgressIndicator.dart';
import 'package:prankbros2/models/WeightCurveModel.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/models/userweight/GetUserWeightApiResponse.dart';
import 'package:prankbros2/popups/CustomUpdateWeightDialog.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Utils.dart';

class WeightCurveWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeightCurveWidget();
}

class _WeightCurveWidget extends State<WeightCurveWidget> {
  List<WeightCurveModel> weightCurveList = new List<WeightCurveModel>();
  WeightCurveBloc _weightCurveBloc;
  SessionManager _sessionManager;
  String userId = '';
  String accessToken = '';

  @override
  void initState() {
    super.initState();
    _weightCurveBloc = new WeightCurveBloc();
    _sessionManager = new SessionManager();
    _sessionManager.getUserModel().then((value) {
      debugPrint("userdata   :        ${value}");
      if (value != null) {
        UserDetails userData = UserDetails.fromJson(value);
        debugPrint('userdata:   :-  ${userData.id}     ${userData.email}');
        userId = userData.id.toString();
        accessToken = userData.accessToken.toString();
        getUserWeight();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void getUserWeight() {
    if (userId == null || userId.isEmpty) {
      Utils.showSnackBar('Something went wrong.', context);
      return;
    }
    Utils.checkConnectivity().then((value) {
      if (value) {
        _weightCurveBloc.getWeightCurve(
            userId: userId, context: context, accessToken: accessToken);
      } else {
        Navigator.pop(context);
        Utils.showSnackBar(
            Strings.please_check_your_internet_connection, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        initialData: 0,
        stream: _weightCurveBloc.progressStream,
        builder: (context, snapshot) {
          if (snapshot.data == 1) {
            return _weightCurveWidget();
          } else if (snapshot.data == 2) {
            // no data found
            return Container(
              height: MediaQuery.of(context).size.height * .57,
              child: _errorWidget(),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height * .57,
              child: Center(child: CommonProgressIndicator(true)),
            );
          }
        });
  }

  Widget _errorWidget() {
    return Container(
      child: Center(
        child: Text(
          'No data found',
          style: TextStyle(
              color: AppColors.black_text,
              fontFamily: Strings.EXO_FONT,
              fontWeight: FontWeight.w700,
              fontSize: Dimens.thirty),
        ),
      ),
    );
  }

  Widget _weightCurveWidget() {
    return StreamBuilder<List<UserProfileWeights>>(
        initialData: null,
        stream: _weightCurveBloc.weightStream,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: Dimens.TWENTY),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: Dimens.fifty,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .57,
                    child: Card(
                      elevation: Dimens.THREE,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimens.ten),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: CustomScrollView(
                        shrinkWrap: true,
                        slivers: <Widget>[
//                          SliverToBoxAdapter(
//                            child:  _addItem(),
//                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return _WeightCurveListItem(
                                    index, snapshot.data[index]);
                              },
                              childCount: snapshot.data.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimens.twentyFive,
                  ),
                ],
              ),
            );
          } else {
            return SizedBox(
              height: 0,
              width: 0,
            );
          }
        });
  }

  Widget _WeightCurveListItem(int index, UserProfileWeights item) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: Dimens.TWENTY,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: Dimens.FIFTEEN,
            ),
            Text(
              item.createdOnStr != null ? item.createdOnStr : "",
              style: TextStyle(
                color: AppColors.black_text,
                fontSize: Dimens.sixteen,
                fontWeight: FontWeight.w700,
              ),
            ),
            Expanded(
              child: Text(
                item.weight != null ? item.weight : "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.light_text,
                  fontSize: Dimens.sixteen,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _plusButtonClick(item: item);
              },
              borderRadius: BorderRadius.all(Radius.circular(Dimens.thirty)),
              child: Container(
                height: Dimens.twentyEight,
                width: Dimens.twentyEight,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimens.thirty)),
                    color: AppColors.light_gray),
                child: Center(
                  child: Image.asset(
                    Images.ICON_PLUS,
                    height: Dimens.twelve,
                    color: AppColors.black_text,
                    width: Dimens.twelve,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: Dimens.TWENTY,
            ),
          ],
        ),
        SizedBox(
          height: Dimens.FIFTEEN,
        ),
        Divider(
            height: Dimens.ONE,
            color: (index == weightCurveList.length - 1)
                ? AppColors.transparent
                : AppColors.divider_color)
      ],
    );
  }

//  Widget _addItem() {
//    return Column(
//      children: <Widget>[
//        SizedBox(
//          height: Dimens.TWENTY,
//        ),
//        Row(
//          children: <Widget>[
//            SizedBox(
//              width: Dimens.FIFTEEN,
//            ),
//            Text(
//              '',
//              style: TextStyle(
//                color: AppColors.black_text,
//                fontSize: Dimens.sixteen,
//                fontWeight: FontWeight.w700,
//              ),
//            ),
//            Expanded(
//              child: Text(
//                '',
//                textAlign: TextAlign.center,
//                style: TextStyle(
//                  color: AppColors.light_text,
//                  fontSize: Dimens.sixteen,
//                  fontWeight: FontWeight.w500,
//                ),
//              ),
//            ),
//            InkWell(
//              onTap: () {
//                _plusButtonClick();
//              },
//              borderRadius: BorderRadius.all(Radius.circular(Dimens.thirty)),
//              child: Container(
//                height: Dimens.twentyEight,
//                width: Dimens.twentyEight,
//                decoration: BoxDecoration(
//                    borderRadius:
//                        BorderRadius.all(Radius.circular(Dimens.thirty)),
//                    color: AppColors.light_gray),
//                child: Center(
//                  child: Image.asset(
//                    Images.ICON_PLUS,
//                    height: Dimens.twelve,
//                    color: AppColors.black_text,
//                    width: Dimens.twelve,
//                  ),
//                ),
//              ),
//            ),
//            SizedBox(
//              width: Dimens.TWENTY,
//            ),
//          ],
//        ),
//        SizedBox(
//          height: Dimens.FIFTEEN,
//        ),
//        Divider(height: Dimens.ONE, color: AppColors.divider_color)
//      ],
//    );
//  }

  void _plusButtonClick({UserProfileWeights item}) {
    showDialog(
        context: context,
        builder: (_) => CustomUpdateWeightDialog(item: item)).then((value) {
      getUserWeight();
    });
  }
}
