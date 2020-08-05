import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prankbros2/app/dashboard/profile/picturewidget/PictureWidgetBloc.dart';
import 'package:prankbros2/customviews/CommonProgressIndicator.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/AppConstantHelper.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Utils.dart';

class CustomImagePickerDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CustomImagePickerDialogState();
  }
}

typedef void OnPickImageCallback();

class _CustomImagePickerDialogState extends State<CustomImagePickerDialog> {
  PickedFile _imageFile;
  dynamic _pickImageError;
  String _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );

    _imageFile = pickedFile;

    _uploadImage();
  }

  void _uploadImage() {
    if (_imageFile == null || _imageFile.path == null) {
      Utils.showToast('Something went wrong', context);
      return;
    }

    Utils.checkConnectivity().then((value) {
      if (value) {
        if (_imageFile.path != null && _imageFile.path.isNotEmpty) {
          isProgressBar = true;
          setState(() {});
          _pictureWidgetBloc.addUserProfileImages(
              userId: userId,
              path: _imageFile.path,
              accessToken: accessToken,
              context: context);
        } else {
          Utils.showToast('Something went wrong', context);
        }
      }
    });
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  bool isProgressBar = false;

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
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimens.TWENTY),
        child: !isProgressBar
            ? Center(
                child: Card(
                  color: AppColors.white,
                  elevation: Dimens.FIVE,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimens.FORTY),
                  ),
                  child: Wrap(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Material(
                                color: AppColors.transparent,
                                child: InkWell(
                                  splashColor: AppColors.pink_stroke,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(Dimens.FORTY),
                                    topRight: Radius.circular(Dimens.FORTY),
                                  ),
                                  onTap: () {
                                    print('Add photo');
//                              requestPermission(Permission.camera, true);
                                    _onImageButtonPressed(ImageSource.camera,
                                        context: context);
//                              Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft:
                                              Radius.circular(Dimens.FORTY),
                                          topRight:
                                              Radius.circular(Dimens.FORTY)),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: Dimens.TWENTY_EIGHT),
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      'Add photo'.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          letterSpacing: 1.04,
                                          color: AppColors
                                              .unSelectedTextRadioColor,
                                          fontSize: Dimens.THRTEEN,
                                          fontFamily: Strings.EXO_FONT,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                color: AppColors.light_gray,
                                height: 1,
                              ),
                              Material(
                                color: AppColors.transparent,
                                child: InkWell(
                                  splashColor: AppColors.pink_stroke,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(Dimens.FORTY),
                                    bottomRight: Radius.circular(Dimens.FORTY),
                                  ),
                                  onTap: () {
                                    print('Add photo from gallery');
//                              if (Platform.isAndroid)
//                                requestPermission(Permission.storage, false);
//                              else
//                                requestPermission(Permission.photos, false);
                                    _onImageButtonPressed(ImageSource.gallery,
                                        context: context);
//                              Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft:
                                              Radius.circular(Dimens.FORTY),
                                          bottomRight:
                                              Radius.circular(Dimens.FORTY)),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(
                                        vertical: Dimens.TWENTY_EIGHT),
                                    child: Text(
                                      'Add photo from gallery'.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          letterSpacing: 1.04,
                                          color: AppColors
                                              .unSelectedTextRadioColor,
                                          fontSize: Dimens.THRTEEN,
                                          fontFamily: Strings.EXO_FONT,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Positioned(
                            right: 30,
                            top: 15,
                            child: Material(
                              child: InkWell(
                                onTap: () {
                                  _dismissLanguagePopUp(context);
                                },
                                child: Image.asset(
                                  Images.ICON_CROSS,
                                  height: Dimens.THIRTY,
                                  width: Dimens.THIRTY,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : Center(child: CommonProgressIndicator(true)),
      ),
    );
  }

  void _dismissLanguagePopUp(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> requestPermission(Permission permission, bool isCamera) async {
    Map<Permission, PermissionStatus> statuses = await [permission].request();
    PermissionStatus permissionStatus = statuses[permission];
    if (permissionStatus == PermissionStatus.granted) {
      await helper.pickImage(
          isCamera: isCamera,
          imagePicked: (file) {
            debugPrint('file path is :--      ${file.path}');
            if (file.path != null && file.path.isNotEmpty) {
              _pictureWidgetBloc.addUserProfileImages(
                  userId: userId,
                  path: file.path,
                  accessToken: accessToken,
                  context: context);
            } else {
              Utils.showToast('Something went wrong', context);
            }
          });
    } else {
      helper.showAlert(true, "need permission");
    }
  }
}
