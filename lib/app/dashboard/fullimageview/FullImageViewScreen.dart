import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/models/profileimage/GetProfileImagesApiResponse.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';

class FullImageViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProfileImages args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: <Widget>[
          FadeInImage(
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              image: NetworkImage(args.imagePath),
              placeholder: AssetImage(Images.DummyFood)),
          Positioned(
            left: Dimens.fifteen,
            top: Dimens.sixty,
            child: InkWell(
              onTap: () {
                _onBackPressed(context);
              },
              child: Container(
                width: Dimens.FORTY_FIVE,
                height: Dimens.FORTY_FIVE,
                child: Container(
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    color: AppColors.light_gray,
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimens.THIRTY)),
                  ),
                  child: Center(
                      child: Image.asset(Images.ArrowBackWhite,
                          height: Dimens.fifteen,
                          width: Dimens.twenty,
                          color: AppColors.black)),
                ),
              ),
            ),
          ),
          Positioned(
            right: Dimens.fifteen,
            top: Dimens.sixty,
            child: InkWell(
              onTap: () {
                _onDeletePressed(context, args);
              },
              child: Container(
                width: Dimens.FORTY_FIVE,
                height: Dimens.FORTY_FIVE,
                child: Container(
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    color: AppColors.light_gray,
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimens.THIRTY)),
                  ),
                  child: Center(
                      child: Image.asset(Images.ICON_DELETE,
                          height: Dimens.fifteen,
                          width: Dimens.twenty,
                          color: AppColors.black)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }

  void _onDeletePressed(BuildContext context, UserProfileImages item) {
    Navigator.pop(context);
  }
}
