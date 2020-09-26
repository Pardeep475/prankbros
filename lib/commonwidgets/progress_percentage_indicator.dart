import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/SizeConfig.dart';

class ProgressIndicatorDownloadFiles extends StatelessWidget {
  var isLoading;
  var progressvalue;
  var totalFiles;
  var currentFile;

  ProgressIndicatorDownloadFiles(
      {this.isLoading, this.progressvalue, this.totalFiles, this.currentFile});

  @override
  Widget build(BuildContext context) {
    final spinkit = Card(
      child: Container(
        height: 110.0,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 24, right: 24),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 8,
                ),
                Container(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.pink_stroke),
                      backgroundColor: Colors.white,
                    )),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    'Downloading File $progressvalue',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Text(
                  '$currentFile/$totalFiles',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
    return isLoading
        ? Opacity(
            opacity: isLoading ? 1.0 : 0,
            child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                color: Colors.transparent,
                child: isLoading
                    ? Container(
                        child: spinkit,
                      )
                    : Container()),
          )
        : Container(
            height: 0.0,
            width: 0.0,
          );
  }
}
