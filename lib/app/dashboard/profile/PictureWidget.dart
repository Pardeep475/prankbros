import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/popups/CustomImagePickerDialog.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';

class PictureWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PictureWidgetState();
}

class _PictureWidgetState extends State<PictureWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimens.fifty)),
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
    showDialog(context: context, builder: (_) => CustomImagePickerDialog());
  }
}
