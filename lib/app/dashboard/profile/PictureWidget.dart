import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/profile/picturewidget/PictureWidgetBloc.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
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
        _pictureWidgetBloc.getUserProfileImages(userId, context);
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
    return Container(
      margin: EdgeInsets.only(top: 100),
      child: Center(
        child: Material(
          child: InkWell(
            onTap: () {
              _selectImageButton();
            },
            borderRadius: BorderRadius.all(Radius.circular(Dimens.fifty)),
            child: Container(
              height: Dimens.seventyFour,
              width: Dimens.seventyFour,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(Dimens.fifty)),
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
    );
  }

  void _selectImageButton() {
    showDialog(
        context: context,
        builder: (_) => CustomImagePickerDialog());
  }
}
