import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/commonwidgets/ease_in_widget.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Strings.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton(
      {key,
      this.text,
      this.backgroundColor,
      this.height,
      this.width,
      this.borderRadius,
      this.onPressed,
      this.isGradient,
      this.loading,
      this.textStyle})
      : super(key: key);

  final String text;
  final Color backgroundColor;
  final double width;
  final double height;
  final bool loading;
  final bool isGradient;
  final double borderRadius;
  final VoidCallback onPressed;
  final TextStyle textStyle;

  Widget buildSpinner(BuildContext context) {
    final ThemeData data = Theme.of(context);

    Color _progressBarColor =
        isGradient ? AppColors.white : AppColors.pink_stroke;

    return Theme(
      data: data.copyWith(accentColor: _progressBarColor),
      child: SizedBox(
        width: 28,
        height: 28,
        child: CircularProgressIndicator(
          strokeWidth: 3,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return EaseInWidget(
      onTap: () {
        onPressed();
      },
      child: SizedBox(
        height: height,
        width: width,
        child: RaisedButton(
          padding: EdgeInsets.all(0),
          elevation: 0,
          child: loading
              ? buildSpinner(context)
              : isGradient ? gradientWidget() : textWidget(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
          // height / 2

          color: backgroundColor,
          focusColor: backgroundColor,
          disabledColor: backgroundColor,
        ),
      ),
    );
  }

  Widget textWidget() {
    return Text(text, style: textStyle);
  }

  Widget gradientWidget() {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        gradient: LinearGradient(
          colors: [AppColors.blue, AppColors.pink],
          begin: Alignment.bottomLeft,
        ),
      ),
      child: Center(child: textWidget()),
    );
  }
}

class CustomSettingButton extends StatelessWidget {
  CustomSettingButton({key, this.text, this.onPressed});

  final text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.only(
              top: Dimens.seventeen,
              bottom: Dimens.seventeen,
              left: Dimens.twenty,
              right: Dimens.thirty),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(
                    letterSpacing: 1,
                    fontFamily: Strings.EXO_FONT,
                    fontWeight: FontWeight.w700,
                    fontSize: Dimens.sixteen,
                    color: AppColors.black_text),
              ),
              Image.asset(
                Images.ICON_NEXT_ARROW,
                height: Dimens.sixteen,
                color: AppColors.black_text,
                width: Dimens.sixteen,
              )
            ],
          ),
          color: Colors.transparent,
        ),
      ),
    );
  }
}

/*
*
* */
