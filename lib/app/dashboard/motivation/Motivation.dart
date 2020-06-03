import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/models/MotivationModel.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';

class Motivation extends StatefulWidget {
  @override
  _MotivationState createState() => _MotivationState();
}

class _MotivationState extends State<Motivation> {
  int _tabClickIndex = 0;
  List<MotivationModel> titleList = new List();
  int _currentTabIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
    this.getTitleList(0);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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

  void _tabClick(int index) {
    setState(() {
      _tabClickIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              Images.TopBg,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: Dimens.SEVENTY,
                    left: Dimens.TWENTY_FIVE,
                    right: Dimens.TWENTY_FIVE),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text(
                        AppLocalizations.of(context)
                            .translate(Strings.motivation),
                        style: TextStyle(
                            color: AppColors.white,
                            fontFamily: Strings.EXO_FONT,
                            fontWeight: FontWeight.w700,
                            fontSize: Dimens.TWENTY_SEVEN),
                      ),
                    ),
                    Row(
                      children: <Widget>[

                        GestureDetector(
                          onTap: () {
                            _tabClick(0);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: Dimens.TWENTY),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: _tabClickIndex == 0
                                        ? AppColors.pink_stroke
                                        : AppColors.transparent),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimens.TWENTY))),
                            padding: EdgeInsets.all(Dimens.TEN),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate(Strings.motivation),
                              style: TextStyle(
                                  color: _tabClickIndex == 0
                                      ? AppColors.pink
                                      : AppColors.white,
                                  fontFamily: Strings.EXO_FONT,
                                  fontWeight: FontWeight.w700,
                                  fontSize: Dimens.THRTEEN),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _tabClick(1);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: Dimens.TEN),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: _tabClickIndex == 0
                                        ? AppColors.transparent
                                        : AppColors.pink_stroke),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimens.TWENTY))),
                            padding: EdgeInsets.all(Dimens.TEN),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate(Strings.history),
                              style: TextStyle(
                                  color: _tabClickIndex == 0
                                      ? AppColors.white
                                      : AppColors.pink,
                                  fontFamily: Strings.EXO_FONT,
                                  fontWeight: FontWeight.w700,
                                  fontSize: Dimens.THRTEEN),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Dimens.TWENTY,
              ),
              Divider(
                color: AppColors.light_gray,
              ),
              Container(
                margin: EdgeInsets.only(
                    left: Dimens.TWENTY_FIVE,
                    right: Dimens.TWENTY_FIVE,
                    top: Dimens.TWENTY,
                    bottom: Dimens.FIFTY),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          '3',
                          style: TextStyle(
                              color: AppColors.white,
                              fontFamily: Strings.EXO_FONT,
                              fontWeight: FontWeight.w600,
                              fontSize: Dimens.EIGHTEEN),
                        ),
                        SizedBox(
                          height: Dimens.FIVE,
                        ),
                        Text(
                          AppLocalizations.of(context)
                              .translate(Strings.workouts),
                          style: TextStyle(
                              color: AppColors.white,
                              fontFamily: Strings.EXO_FONT,
                              fontWeight: FontWeight.w500,
                              fontSize: Dimens.TWELVE),
                        ),
                      ],
                    ),
                    Container(
                      color: AppColors.light_gray,
                      height: Dimens.FORTY,
                      width: Dimens.ONE,
//                      margin: EdgeInsets.only(top: Dimens.TEN,bottom: Dimens.TEN),
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          '1',
                          style: TextStyle(
                              color: AppColors.white,
                              fontFamily: Strings.EXO_FONT,
                              fontWeight: FontWeight.w600,
                              fontSize: Dimens.EIGHTEEN),
                        ),
                        SizedBox(
                          height: Dimens.FIVE,
                        ),
                        Text(
                          AppLocalizations.of(context).translate(Strings.week),
                          style: TextStyle(
                              color: AppColors.white,
                              fontFamily: Strings.EXO_FONT,
                              fontWeight: FontWeight.w500,
                              fontSize: Dimens.TWELVE),
                        ),
                      ],
                    ),
                    Container(
                      color: AppColors.light_gray,
                      height: 40,
                      width: 1,
//                      margin: EdgeInsets.only(top: Dimens.TEN,bottom: Dimens.TEN),
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          '1/4',
                          style: TextStyle(
                              color: AppColors.white,
                              fontFamily: Strings.EXO_FONT,
                              fontWeight: FontWeight.w600,
                              fontSize: Dimens.EIGHTEEN),
                        ),
                        SizedBox(
                          height: Dimens.FIVE,
                        ),
                        Text(
                          AppLocalizations.of(context)
                              .translate(Strings.motivation),
                          style: TextStyle(
                              color: AppColors.white,
                              fontFamily: Strings.EXO_FONT,
                              fontWeight: FontWeight.w500,
                              fontSize: Dimens.TWELVE),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                child: _tabClickIndex == 0
                    ? _motivationWidget()
                    : _historyWidget(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _motivationWidget() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimens.TWENTY),
        child: GridView.builder(
          itemBuilder: (context, position) {
            return Card(
              margin: EdgeInsets.all(Dimens.SEVEN),
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimens.TWENTY))),
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
      ),
    );
  }

  Widget _motivationNormalWidget(int position) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(Images.Cup),
        Container(
            margin: EdgeInsets.only(top: Dimens.THRTEEN),
            child: Text(
              '${titleList[position].count} ${titleList[position].title}',
              style: TextStyle(
                  fontSize: Dimens.THRTEEN,
                  fontFamily: Strings.EXO_FONT,
                  fontWeight: FontWeight.w700,
                  color: AppColors.light_text),
              textAlign: TextAlign.center,
            )),
      ],
    );
  }

  Widget _motivationImageWidget(int position) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.TWENTY),
          child: Image.asset(
            Images.DummyFood,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Center(
          child: Image.asset(Images.ICON_PLAY),
        ),
      ],
    );
  }

  Widget _historyWidget() {
    return Center(
      child: Text(
        'In progress',
        style: TextStyle(
            color: AppColors.black_text,
            fontFamily: 'Exo 2',
            fontSize: Dimens.THIRTY),
      ),
    );
  }
}
