import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/models/WeightCurveModel.dart';
import 'package:prankbros2/popups/CustomUpdateWeightDialog.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';

class WeightCurveWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeightCurveWidget();
}

class _WeightCurveWidget extends State<WeightCurveWidget> {
  List<WeightCurveModel> weightCurveList = new List<WeightCurveModel>();

  @override
  void initState() {
    super.initState();
    _weightCurveList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _weightCurveWidget();
  }

  Widget _weightCurveWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimens.TWENTY),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: Dimens.sixtyFive,
          ),
          Expanded(
            child: Card(
              elevation: Dimens.THREE,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimens.FORTY),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return _WeightCurveListItem(index);
                      },
                      childCount: weightCurveList.length,
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
  }

  // ignore: non_constant_identifier_names
  Widget _WeightCurveListItem(int index) {
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
              weightCurveList[index].timeStamp,
              style: TextStyle(
                color: AppColors.black_text,
                fontSize: Dimens.sixteen,
                fontWeight: FontWeight.w700,
              ),
            ),
            Expanded(
              child: Text(
                weightCurveList[index].weight,
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
                _plusButtonClick(index);
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

  void _weightCurveList() {
    for (int i = 0; i < 10; i++) {
      weightCurveList
          .add(WeightCurveModel(timeStamp: '01.01.2019', weight: '103.5 KG'));
    }
  }

  void _plusButtonClick(int index) {
    showDialog(context: context, builder: (_) => CustomUpdateWeightDialog());
  }
}
