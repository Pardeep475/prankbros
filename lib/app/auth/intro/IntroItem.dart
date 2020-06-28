import 'package:flutter/material.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';

class IntroItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color bg;
  final String imageUrl;

  const IntroItem({Key key, this.title, this.subTitle, this.bg, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(this.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Container(
          child: Center(
            child: Wrap(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      left: Dimens.FORTY,right: Dimens.FORTY, top: Dimens.TWENTY,bottom: Dimens.THIRTY),
                  margin: EdgeInsets.only(right: Dimens.FORTY),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimens.ONE_ONE_SEVEN),
                          bottomRight: Radius.circular(Dimens.ONE_ONE_SEVEN)),
                      gradient: LinearGradient(
                        colors: [AppColors.pink, AppColors.blue],
                        begin: Alignment.bottomLeft,
                      )),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context).translate(this.title),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              letterSpacing: 4.64,
                              fontFamily: Strings.EXO_FONT,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w900,
                              fontSize: Dimens.SIXTY_FIVE,
                              color: Colors.white),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: Dimens.TEN),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate(this.subTitle),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: Strings.EXO_FONT,
                                fontSize: Dimens.SEVENTEEN,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
