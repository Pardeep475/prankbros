import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/profile/picturewidget/PictureWidgetBloc.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/models/profileimage/GetProfileImagesApiResponse.dart';
import 'package:prankbros2/popups/CustomResetYourProgramDialog.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Utils.dart';

class FullImageViewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FullImageViewScreenState();
}

class _FullImageViewScreenState extends State<FullImageViewScreen> {
  String userId = '';
  String accessToken = '';
  SessionManager _sessionManager;
  PictureWidgetBloc _pictureWidgetBloc;

  @override
  void initState() {
    super.initState();
    _pictureWidgetBloc = new PictureWidgetBloc();
    _sessionManager = new SessionManager();

    _sessionManager.getUserModel().then((value) {
      debugPrint("userdata   :        ${value}");
      if (value != null) {
        UserDetails userData = UserDetails.fromJson(value);
        debugPrint('userdata:   :-  ${userData.id}     ${userData.email}');
        userId = userData.id.toString();
        accessToken = userData.accessToken.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProfileImages args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: <Widget>[
//          FadeInImage(
//              fit: BoxFit.fill,
//              width: MediaQuery.of(context).size.width,
//              height: MediaQuery.of(context).size.height,
//              image: NetworkImage(args.imagePath),
//              placeholder: AssetImage(Images.DummyFood)),
          CachedNetworkImage(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            imageUrl: args.imagePath,
            imageBuilder: (context, imageProvider) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) =>
                Utils.getImagePlaceHolderWidgetProfile(
                    context: context,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width),
            errorWidget: (context, url, error) =>
                Utils.getImagePlaceHolderWidgetProfile(
                    context: context,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width),
          ),
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
            child: Builder(
              builder: (BuildContext context) {
                return InkWell(
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
                );
              },
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
    showDialog(
        context: context,
        builder: (_) => CustomResetYourProgramDialog(
              title: "Are you sure want to delete?",
              value: 1,
              yesPressed: () {
                _deleteImage(context, item);
              },
            )).then((value) {
      Navigator.pop(context);
    });
  }

  void _deleteImage(BuildContext context, UserProfileImages item) {
    Utils.checkConnectivity().then((value) {
      if (value) {
        _pictureWidgetBloc.deleteUserProfileImages(
            userId: userId,
            id: item.id.toString(),
            context: context,
            accessToken: accessToken);
      } else {
        Navigator.pop(context);
        Utils.showSnackBar(
            Strings.please_check_your_internet_connection, context);
      }
    });
  }
}
