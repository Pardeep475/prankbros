import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/motivation/MotivationBloc.dart';
import 'package:prankbros2/models/MotivationModel.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/models/motivation/MotivationApiResponse.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Utils.dart';

class MotivationWidget extends StatefulWidget {
  final MotivationData motivationData;

  MotivationWidget({this.motivationData});

  @override
  State<StatefulWidget> createState() =>
      _MotivationWidgetState(motivationData: this.motivationData);
}

class _MotivationWidgetState extends State<MotivationWidget> {
  final MotivationData motivationData;

  _MotivationWidgetState({this.motivationData});

  List<MotivationModel> titleList = new List();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.getTitleList(0);
  }

  void setData() {}

  void getTitleList(int index) {
    if (titleList.length > 0) {
      titleList.clear();
    }
    if (motivationData.imagePath1 != null ||
        motivationData.videoPath1 != null) {
      titleList.add(MotivationModel(
          count: 0,
          title: '',
          imgPath: motivationData.imagePath1,
          videoPath: motivationData.videoPath1));
    } else {
      titleList.add(MotivationModel(
          count: 4, title: 'workouts', imgPath: null, videoPath: null));
    }

    if (motivationData.imagePath2 != null ||
        motivationData.videoPath2 != null) {
      titleList.add(MotivationModel(
          count: 0,
          title: '',
          imgPath: motivationData.imagePath2,
          videoPath: motivationData.videoPath2));
    } else {
      titleList.add(MotivationModel(
          count: 12, title: 'workouts', imgPath: null, videoPath: null));
    }

    if (motivationData.imagePath3 != null ||
        motivationData.videoPath3 != null) {
      titleList.add(MotivationModel(
          count: 0,
          title: '',
          imgPath: motivationData.imagePath3,
          videoPath: motivationData.videoPath3));
    } else {
      titleList.add(MotivationModel(
          count: 24, title: 'workouts', imgPath: null, videoPath: null));
    }

    if (motivationData.imagePath4 != null ||
        motivationData.videoPath4 != null) {
      titleList.add(MotivationModel(
          count: 0,
          title: '',
          imgPath: motivationData.imagePath4,
          videoPath: motivationData.videoPath4));
    } else {
      titleList.add(MotivationModel(
          count: 36, title: 'workouts', imgPath: null, videoPath: null));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimens.twenty, top: Dimens.sixty, right: Dimens.twenty),
      child: titleList.length > 0
          ? GridView.builder(
              padding: EdgeInsets.only(
                  top: 0, left: 0, right: 0, bottom: Dimens.twenty),
              itemBuilder: (context, position) {
                return Card(
                  margin: EdgeInsets.all(Dimens.seven),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.twenty))),
                  child: Center(
                      child: titleList[position].count == 0
                          ? _motivationImageWidget(position)
                          : _motivationNormalWidget(position)),
                );
              },
              itemCount: titleList.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            )
          : _errorData(),
    );
  }

  Widget _errorData() {
    return Center(
      child: Text(
        'No data found',
        style: TextStyle(
            color: AppColors.black_text,
            fontFamily: Strings.EXO_FONT,
            fontWeight: FontWeight.w700,
            fontSize: Dimens.thirty),
      ),
    );
  }

  Widget _motivationNormalWidget(int position) {
    return Builder(
      builder: (BuildContext context) {
        return Material(
          color: AppColors.transparent,
          child: InkWell(
            splashColor: AppColors.pink_stroke,
            onTap: () {
              Utils.showSnackBar("This item not available right now.", context);
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
      },
    );
  }

  Widget _motivationImageWidget(int position) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(Images.DummyFood),
        fit: BoxFit.cover,
      )),
      child: Stack(
        children: <Widget>[
//          FadeInImage(
//              fit: BoxFit.cover,
//              width: MediaQuery.of(context).size.width,
//              height: MediaQuery.of(context).size.height,
//              image: NetworkImage(titleList[position].imgPath),
//              placeholder: AssetImage(Images.DummyFood)),
          CachedNetworkImage(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            imageUrl: titleList[position].imgPath,
            imageBuilder: (context, imageProvider) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => Utils.getAssetImage(
                MediaQuery.of(context).size.height,
                MediaQuery.of(context).size.width),
            errorWidget: (context, url, error) =>
                Utils.getImagePlaceHolderWidgetProfile(
                    context: context,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width),
          ),
          Material(
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
        ],
      ),
    );
  }

  void _motivationItemClick(int index) {
    debugPrint('videoPathis ----->  ${titleList[index].videoPath}');
    Navigator.pushNamed(context, Strings.VIDEO_PLAYER_ROUTE,
        arguments: titleList[index].videoPath);
  }
}
