import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/models/MotivationModel.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';

class MotivationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MotivationWidgetState();
}

class _MotivationWidgetState extends State<MotivationWidget> {
  List<MotivationModel> titleList = new List();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.getTitleList(0);
  }

  void getTitleList(int index) {
    if (titleList.length > 0) {
      titleList.clear();
    }
    titleList.add(MotivationModel(0, "workouts"));
    titleList.add(MotivationModel(24, "workouts"));
    titleList.add(MotivationModel(36, "workouts"));
    titleList.add(MotivationModel(48, "workouts"));
    titleList.add(MotivationModel(0, "workouts"));
    titleList.add(MotivationModel(24, "workouts"));
    titleList.add(MotivationModel(36, "workouts"));
    titleList.add(MotivationModel(48, "workouts"));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(
          left: Dimens.twenty, top: Dimens.sixty, right: Dimens.twenty),
      child: GridView.builder(
        padding:
        EdgeInsets.only(top: 0, left: 0, right: 0, bottom: Dimens.twenty),
        itemBuilder: (context, position) {
          return Card(
            margin: EdgeInsets.all(Dimens.seven),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(Dimens.twenty))),
            child: Center(
                child: titleList[position].count == 0
                    ? _motivationImageWidget(position)
                    : _motivationNormalWidget(position)),
          );
        },
        itemCount: titleList.length,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      ),
    );
  }



  Widget _motivationNormalWidget(int position) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        splashColor: AppColors.pink_stroke,
        onTap: () {
          _motivationItemClick(position);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(Images.Cup),
              SizedBox(
                height: Dimens.thrteen,
              ),
              Text(
                '${titleList[position].count} ${titleList[position].title}',
                style: TextStyle(
                    fontSize: Dimens.thrteen,
                    fontFamily: Strings.EXO_FONT,
                    fontWeight: FontWeight.w700,
                    color: AppColors.light_text),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _motivationImageWidget(int position) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(Images.DummyFood),
        fit: BoxFit.cover,
      )),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          splashColor: AppColors.pink_stroke,
          onTap: () {
            _motivationItemClick(position);
          },
          child: Center(
            child: Image.asset(Images.ICON_PLAY),
          ),
        ),
      ),
    );
  }

  void _motivationItemClick(int index) {
    debugPrint('Motivation Item click ${index.toString()}');
  }
}
