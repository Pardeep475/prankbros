import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prankbros2/app/dashboard/profile/PictureWidget.dart';
import 'package:prankbros2/app/dashboard/profile/ProfileWidget.dart';
import 'package:prankbros2/app/dashboard/profile/SettingsWidget.dart';
import 'package:prankbros2/app/dashboard/profile/picturewidget/PictureWidgetBloc.dart';
import 'package:prankbros2/models/login/LoginResponse.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Utils.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';
import 'package:prankbros2/utils/network/ApiRepository.dart';
import 'package:rxdart/rxdart.dart';
import '../../../utils/AppColors.dart';
import 'PictureWidget.dart';
import 'SettingsWidget.dart';
import 'WeightCurveWidget.dart';

var profilepic = "";

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  int itemPos = 0;
  List<String> _titleList = new List();
  SessionManager _sessionManager;
  var name = "";
  var userId = "";
  var accessToken = "";

  var email = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _titleListInit();
  }

  ApiRepository apiRepository;
  BehaviorSubject<int> toggleProfilePicsink = BehaviorSubject<int>();

  Stream<int> get streamProfilePic => toggleProfilePicsink.stream;

  @override
  void initState() {
    super.initState();

    super.initState();
  }

  void _titleListInit() {
    _titleList.add(AppLocalizations.of(context).translate(Strings.Profile));
    _titleList.add(AppLocalizations.of(context).translate(Strings.Pictures));
    _titleList.add(AppLocalizations.of(context).translate(Strings.WeightCurve));
    _titleList.add(AppLocalizations.of(context).translate(Strings.Settings));
    _sessionManager = SessionManager();
    _sessionManager.getUserModel().then((value) {
      debugPrint("userdataPPP   :        $value");
      if (value != null) {
        UserDetails userData = UserDetails.fromJson(value);
        debugPrint('userdata:   :-  ${userData.id}     ${userData.email}');
        name = userData.firstName;
        email = userData.email;
        userId = userData.id.toString();
        accessToken = userData.accessToken.toString();
        apiRepository = new ApiRepository();
        _sessionManager.getProfilePic().then((value) {
          profilepic = value;
          print("profilepic${profilepic}");
          toggleProfilePicsink.sink.add(1);
          if (profilepic == "") {
           // getProfilePic();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: Dimens.threeHundred,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.TopBg),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
//            margin: EdgeInsets.symmetric(horizontal: Dimens.FORTY),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: Dimens.seventyFive,
                  ),
                  _topUserProfile(),
                  SizedBox(
                    height: Dimens.twentyFive,
                  ),
                  Divider(
                    height: Dimens.one,
                    color: AppColors.divider_color,
                  ),
                  SizedBox(
                    height: Dimens.twentyFive,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: Dimens.twentyFive,
                      right: 0,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: Dimens.forty,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemCount: _titleList.length,
                        itemBuilder: (BuildContext conntext, int pos) {
                          return _customTextWidget(_titleList[pos], pos);
                        }),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: openSpecificTab(itemPos)),
                ],
              ),
            ),
          ],
        ),
      ),
    )

        /*Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.TopBg),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Scaffold(
          resizeToAvoidBottomPadding: false,
          resizeToAvoidBottomInset : false,
          backgroundColor: AppColors.transparent,
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: Dimens.FORTY),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: Dimens.seventyFive,
                ),
                _topUserProfile(),
                SizedBox(
                  height: Dimens.thirty,
                ),
                Divider(
                  height: Dimens.one,
                  color: AppColors.divider_color,
                ),
                SizedBox(
                  height: Dimens.twentyFive,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: Dimens.fifty,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                      itemCount: _titleList.length,
                      itemBuilder: (BuildContext conntext, int pos) {
                        return _customTextWidget(_titleList[pos], pos);
                      }),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: openSpecificTab(itemPos)),
              ],
            ),
          ),
        ),
      ],
    )*/
        ;
  }

  Widget openSpecificTab(int pos) {
    switch (pos) {
      case 0:
        {
          return ProfileWidget();
        }
        break;
      case 1:
        {
          return PictureWidget();
        }
        break;
      case 2:
        {
          return WeightCurveWidget();
        }
        break;
      case 3:
        {
          return SettingsWidget();
        }
        break;
      default:
        {
          return ProfileWidget();
        }
        break;
    }
  }

  /*
  *
  * return Scaffold(
      backgroundColor: AppColors.transparent,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: BackgroundWidgetWithColor(
              curveColor: AppColors.workoutDetail2BackColor,
            ),
          ),
          DefaultTabController(
            length: 4, // Added
            initialIndex: 0,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: Dimens.seventyFive,
                ),
                _topUserProfile(),
                SizedBox(
                  height: Dimens.thirty,
                ),
                Divider(
                  height: Dimens.one,
                  color: AppColors.divider_color,
                ),
                SizedBox(
                  height: Dimens.twentyFive,
                ),
                _tabBarWidget(),
                _tabBarViewWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  * */

  Widget _topUserProfile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin:
              EdgeInsets.only(left: Dimens.TWENTY_FIVE, right: Dimens.TWENTY),
          width: Dimens.sixty,
          height: Dimens.sixty,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(
              Dimens.sixty,
            )),
            child: StreamBuilder<int>(
                stream: streamProfilePic,
                initialData: -1,
                builder: (context, snapshot) {
                  return snapshot.data == -1
                      ? Utils.getAssetImage(
                          Dimens.sixty,
                          Dimens.sixty,
                        )
                      : CachedNetworkImage(
                          imageUrl: profilepic!=null?profilepic:"",
                          fit: BoxFit.fill,
                          width: Dimens.sixty,
                          height: Dimens.sixty,
                          placeholder: (context, url) => Utils.getAssetImage(
                                Dimens.sixty,
                                Dimens.sixty,
                              ),
                          errorWidget: (context, url, error) =>
                              Utils.getFailedImage(
                                Dimens.sixty,
                                Dimens.sixty,
                              ));
                }),
          ),
        ),
        SizedBox(
          height: Dimens.TWENTY,
        ),
        StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '$name',
                    style: TextStyle(
                        fontFamily: Strings.EXO_FONT,
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: Dimens.TWENTY_SEVEN),
                  ),
                  SizedBox(
                    height: Dimens.FIVE,
                  ),
                  Text(
                    '$email',
                    style: TextStyle(
                        fontFamily: Strings.EXO_FONT,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                        fontSize: Dimens.FORTEEN),
                  ),
                ],
              );
            })
      ],
    );
  }

  Widget _customTextWidget(String title, int pos) {
    return GestureDetector(
      onTap: () {
        setState(() {
          itemPos = pos;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: itemPos == pos
                    ? AppColors.pink_stroke
                    : AppColors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(Dimens.twenty))),
        padding: EdgeInsets.symmetric(
            vertical: Dimens.ten, horizontal: Dimens.twenty),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: itemPos == pos ? AppColors.pink : AppColors.white,
                fontFamily: Strings.EXO_FONT,
                fontWeight: FontWeight.w700,
                fontSize: Dimens.thrteen),
          ),
        ),
      ),
    );
  }

  Widget _tabBarWidget() {
    return TabBar(
      isScrollable: true,
      unselectedLabelColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppColors.pink,
      indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.FIFTY),
          border: Border.all(color: AppColors.pink_stroke, width: Dimens.ONE)),
      tabs: <Widget>[
        Tab(
          child: Align(
            alignment: Alignment.center,
            child:
                Text(AppLocalizations.of(context).translate(Strings.Profile)),
          ),
        ),
        Tab(
          child: Align(
            alignment: Alignment.center,
            child:
                Text(AppLocalizations.of(context).translate(Strings.Pictures)),
          ),
        ),
        Tab(
          child: Align(
            alignment: Alignment.center,
            child: Text(
                AppLocalizations.of(context).translate(Strings.WeightCurve)),
          ),
        ),
        Tab(
          child: Align(
            alignment: Alignment.center,
            child:
                Text(AppLocalizations.of(context).translate(Strings.Settings)),
          ),
        ),
      ],
    );
  }


}

class NameEmailData {
  String name;
  String email;

  NameEmailData({this.name, this.email});
}
