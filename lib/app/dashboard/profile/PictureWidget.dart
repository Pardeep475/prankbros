import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/profile/picturewidget/PictureWidgetBloc.dart';
import 'package:prankbros2/customviews/CommonProgressIndicator.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/models/profileimage/GetProfileImagesApiResponse.dart';
import 'package:prankbros2/models/profileimage/PictureFinalModel.dart';
import 'package:prankbros2/popups/CustomImagePickerDialog.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/AppConstantHelper.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Utils.dart';

class PictureWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PictureWidgetState();
}

class _PictureWidgetState extends State<PictureWidget> {
  AppConstantHelper helper = AppConstantHelper();
  var filePath = "";
  SessionManager _sessionManager;
  String userId = '';
  String accessToken = '';
  PictureWidgetBloc _pictureWidgetBloc;

  @override
  void initState() {
    super.initState();
    _pictureWidgetBloc = new PictureWidgetBloc();
    _sessionManager = new SessionManager();
    _sessionManager.getUserModel().then((value) {
      debugPrint("userdata   :        $value");
      if (value != null) {
        UserDetails userData = UserDetails.fromJson(value);
        debugPrint('userdata:   :-  ${userData.id}     ${userData.email}');
        userId = userData.id.toString();
        accessToken = userData.accessToken.toString();
        getUserWeight();
      }
    });
  }

  void getUserWeight() {
    if (userId == null || userId.isEmpty) {
      Utils.showSnackBar('Something went wrong.', context);
      return;
    }
    Utils.checkConnectivity().then((value) {
      if (value) {
        _pictureWidgetBloc.getUserProfileImages(
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
    return _picturesWidget();
  }

  Widget _picturesWidget() {
    return StreamBuilder<int>(
        initialData: 0,
        stream: _pictureWidgetBloc.progressStream,
        builder: (context, snapshot) {
          if (snapshot != null && snapshot.data != null) {
            if (snapshot.data == 0) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.62,
                child: Center(child: CommonProgressIndicator(true)),
              );
            } else if (snapshot.data == 1) {
              return Container(
                child: StreamBuilder<List<PictureFinalModel>>(
                    initialData: null,
                    stream: _pictureWidgetBloc.weightStream,
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return Column(
                          children: <Widget>[
                            SizedBox(
                              height: Dimens.thirty,
                            ),
//                            _imageListItem(snapshot.data)
                            Container(
                              height: MediaQuery.of(context).size.height * 0.62,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext context, int pos) {
                                    if (pos == 0) {
                                      return Column(
                                        children: <Widget>[
                                          snapshot.data.length <= 0
                                              ? Container(
                                                  child: Center(
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      child: InkWell(
                                                        onTap: () {
                                                          _selectImageButton();
                                                        },
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    Dimens
                                                                        .fifty)),
                                                        child: Card(
                                                          color: AppColors
                                                              .light_gray,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(Dimens
                                                                        .fifty),
                                                          ),
                                                          elevation:
                                                              Dimens.three,
                                                          child: Container(
                                                            height: Dimens
                                                                .seventyFour,
                                                            width: Dimens
                                                                .seventyFour,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(Dimens
                                                                            .fifty)),
                                                                color: AppColors
                                                                    .light_gray),
                                                            child: Center(
                                                              child:
                                                                  Image.asset(
                                                                Images
                                                                    .ICON_PLUS,
                                                                height: Dimens
                                                                    .twentyFour,
                                                                width: Dimens
                                                                    .twentyFour,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    onTap: () {
                                                      _selectImageButton();
                                                    },
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                Dimens.fifty)),
                                                    child: Card(
                                                      color:
                                                          AppColors.light_gray,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(Dimens
                                                                    .fifty),
                                                      ),
                                                      elevation: Dimens.three,
                                                      child: Container(
                                                        height:
                                                            Dimens.seventyFour,
                                                        width:
                                                            Dimens.seventyFour,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        Dimens
                                                                            .fifty)),
                                                            color: AppColors
                                                                .light_gray),
                                                        child: Center(
                                                          child: Image.asset(
                                                            Images.ICON_PLUS,
                                                            height: Dimens
                                                                .twentyFour,
                                                            width: Dimens
                                                                .twentyFour,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          SizedBox(
                                            height: Dimens.forty,
                                          ),
                                          _imageListItem(snapshot.data[pos])
                                        ],
                                      );
                                    } else {
                                      return _imageListItem(snapshot.data[pos]);
                                    }
                                  }),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: <Widget>[
                            SizedBox(
                              height: Dimens.hundred,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.62,
                              child: Center(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      _selectImageButton();
                                    },
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Dimens.fifty)),
                                    child: Card(
                                      color: AppColors.light_gray,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(Dimens.fifty),
                                      ),
                                      elevation: Dimens.three,
                                      child: Container(
                                        height: Dimens.seventyFour,
                                        width: Dimens.seventyFour,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(Dimens.fifty)),
                                            color: AppColors.light_gray),
                                        child: Center(
                                          child: Image.asset(
                                            Images.ICON_PLUS,
                                            height: Dimens.twentyFour,
                                            width: Dimens.twentyFour,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    }),
              );
            } else {
              return Container(
                height: MediaQuery.of(context).size.height * 0.62,
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        _selectImageButton();
                      },
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.fifty)),
                      child: Card(
                        color: AppColors.light_gray,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimens.fifty),
                        ),
                        elevation: Dimens.three,
                        child: Container(
                          height: Dimens.seventyFour,
                          width: Dimens.seventyFour,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimens.fifty)),
                              color: AppColors.light_gray),
                          child: Center(
                            child: Image.asset(
                              Images.ICON_PLUS,
                              height: Dimens.twentyFour,
                              width: Dimens.twentyFour,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          } else {
            return Container(
              height: MediaQuery.of(context).size.height * 0.62,
              child: Center(child: CommonProgressIndicator(true)),
            );
          }
        });
  }

  Widget _imageListItem(PictureFinalModel item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _headerItem(item.title),
        SizedBox(
          height: Dimens.twenty,
        ),
        GridView.builder(
          padding: EdgeInsets.only(
              top: 0,
              left: Dimens.ten,
              right: Dimens.twenty,
              bottom: Dimens.ten),
          itemCount: item.list.length,
          itemBuilder: (context, position) {
            debugPrint('------------>itembuilder   ${position}');
            return _mainItem(item.list[position]);
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 4 / 4,
          ),
          shrinkWrap: true,
          primary: false,
          physics: ClampingScrollPhysics(),
        ),
      ],
    );
  }

  Widget _headerItem(String item) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.twenty),
      child: Text(
        item,
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: Dimens.twenty,
            color: AppColors.black_text,
            fontFamily: Strings.EXO_FONT),
      ),
    );
  }

  Widget _mainItem(UserProfileImages item) {
    debugPrint('imageitem:--->   $item');
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          imageClick(item);
        },
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(left: Dimens.ten, bottom: Dimens.ten),
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: CachedNetworkImage(
              width: Dimens.seventy,
              height: Dimens.fifty,
              imageUrl: item.imagePath,
              imageBuilder: (context, imageProvider) => Container(
                width: Dimens.seventy,
                height: Dimens.fifty,
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) =>
                  Utils.getImagePlaceHolderWidgetProfile(
                      context: context,
                      height: Dimens.fifty,
                      width: Dimens.seventy),
              errorWidget: (context, url, error) =>
                  Utils.getImagePlaceHolderWidgetProfile(
                      context: context,
                      height: Dimens.fifty,
                      width: Dimens.seventy),
            ),
          ),
        ),
      ),
    );
  }

  void imageClick(UserProfileImages item) {
    Navigator.pushNamed(context, Strings.FULL_IMAGE_VIEW_SCREEN,
            arguments: item)
        .then((value) {
      getUserWeight();
    });
  }

  void _selectImageButton() {
    showDialog(context: context, builder: (_) => CustomImagePickerDialog())
        .then((value) {
      getUserWeight();
    });
  }
}


/*
*  /* FadeInImage(
                fit: BoxFit.cover,
                width: Dimens.seventy,
                height: Dimens.fifty,
                image: NetworkImage(item.imagePath),
                placeholder: AssetImage(Images.DummyFood))*/
*
* */
