import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/profile/picturewidget/PictureWidgetBloc.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/models/profileimage/GetProfileImagesApiResponse.dart';
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
    return Column(
      children: <Widget>[
        SizedBox(
          height: Dimens.hundred,
        ),
        StreamBuilder<List<UserProfileImages>>(
            initialData: null,
            stream: _pictureWidgetBloc.weightStream,
            builder: (context, snapshot) {
              if(snapshot.data != null){
                return GridView.builder(
                  padding: EdgeInsets.only(
                      top: 0, left: 0, right: 0, bottom: Dimens.twenty),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, position) {
                    debugPrint('------------>itembuilder   ${position}');
                    return _mainItem(snapshot.data[position].imagePath);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.73,
                  ),
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                );
              }else{
                return SizedBox(height: 0,width: 0,);
              }
            }),
        Center(
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
      ],
    );
  }

  Widget _headerItem(String item) {
    return Text(
      item,
      style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: Dimens.twenty,
          color: AppColors.black_text,
          fontFamily: Strings.EXO_FONT),
    );
  }

  Widget _mainItem(String item) {
    return FadeInImage(
        fit: BoxFit.cover,
        width: Dimens.seventyFive,
        height: Dimens.seventyFive,
        image: NetworkImage(item),
        placeholder: AssetImage(Images.DummyFood));
  }

  void _selectImageButton() {
    showDialog(context: context, builder: (_) => CustomImagePickerDialog());
  }
}
