import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/AppConstantHelper.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';

class CustomImagePickerDialog extends StatelessWidget {
  AppConstantHelper helper = AppConstantHelper();
  Function(File) onFilePicked;
  CustomImagePickerDialog(context, Function(File) onFilePicked);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimens.TWENTY),
        child: Center(
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
                              requestPermission(Permission.camera, true);

                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(Dimens.FORTY),
                                    topRight: Radius.circular(Dimens.FORTY)),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimens.TWENTY_EIGHT),
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                'Add photo'.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    letterSpacing: 1.04,
                                    color: AppColors.unSelectedTextRadioColor,
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
                              if (Platform.isAndroid)
                                requestPermission(Permission.storage, false);
                              else
                                requestPermission(Permission.photos, false);

                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(Dimens.FORTY),
                                    bottomRight: Radius.circular(Dimens.FORTY)),
                              ),
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimens.TWENTY_EIGHT),
                              child: Text(
                                'Add photo from gallery'.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    letterSpacing: 1.04,
                                    color: AppColors.unSelectedTextRadioColor,
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
        ),
      ),
    );
  }

  void _dismissLanguagePopUp(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> requestPermission(Permission permission, bool isCamera) async {
    Map<Permission, PermissionStatus> statuses = await [permission].request();
    PermissionStatus permissionStatus = statuses[permission];
    print("pickImage>>>>>${permissionStatus}");
    if (permissionStatus == PermissionStatus.granted) {
      await helper.pickImage(
          isCamera: isCamera,
          imagePicked: (file) {
            print("pickImage>>>>>${file.path}");
            onFilePicked(file);
          });
    } else {
      helper.showAlert(true, "need permission");
    }
  }
}
