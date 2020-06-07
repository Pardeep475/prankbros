import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/BackgroundWidgetWithImage.dart';
import 'package:prankbros2/app/dashboard/motivation/Motivation.dart';
import 'package:prankbros2/app/dashboard/nutrition/Nutrition.dart';
import 'package:prankbros2/app/dashboard/profile/Profile.dart';
import 'package:prankbros2/app/dashboard/workouts/ComingUp.dart';
import 'package:prankbros2/app/dashboard/workouts/ComingUpNextWorkout.dart';
import 'package:prankbros2/app/dashboard/workouts/Workouts.dart';
import 'package:prankbros2/customviews/CustomViews.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Dimens.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/Keys.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';

class WorkoutDetails2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WorkoutDetails2State();
}

class _WorkoutDetails2State extends State<WorkoutDetails2> {
  static const Key downloadWorkoutButtonKey =
      Key(Keys.downloadWorkoutButtonKey);
  int _selectedIndex = 0;
  bool _isItemClick = false;
  bool _isLoading = false;

  void _onItemTapped(int index) {
    _isItemClick = true;
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _callPages(int index) {
    switch (index) {
      case 0:
        {
          return Workouts();
        }
        break;
      case 1:
        {
          return Motivation();
        }
        break;
      case 2:
        {
          return Nutrition();
        }
        break;
      case 3:
        {
          return Profile();
        }
        break;
      default:
        {
          return Workouts();
        }
        break;
    }
  }

  Widget _WorkoutDetails2Widget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 40,
        ),
        Container(
          margin: EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(90)),
          ),
          child: Image.asset(
            Images.ArrowBackWhite,
            color: AppColors.black,
            fit: BoxFit.none,
            width: 35.0,
            height: 35.0,
          ),
        ),
        SizedBox(
          height: 95,
        ),
        Padding(
          padding: EdgeInsets.only(left: 35),
          child: Text(
            'Full Body',
            style: TextStyle(
                fontSize: Dimens.TWENTY_SIX,
                fontWeight: FontWeight.w900,
                color: AppColors.white,
                letterSpacing: 0.75,
                fontFamily: Strings.EXO_FONT,
                fontStyle: FontStyle.italic),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          margin: EdgeInsets.only(left: 35),
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(90)),
            gradient: LinearGradient(
              colors: [AppColors.pink, AppColors.blue],
              begin: Alignment.bottomLeft,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              Image.asset(Images.ICON_TIMER),
              SizedBox(
                width: 10,
              ),
              Wrap(
                children: <Widget>[
                  Text(
                    '30 min',
                    style: TextStyle(
                      fontSize: Dimens.FORTEEN,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                      fontFamily: Strings.EXO_FONT,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 55,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
            style: TextStyle(
              fontSize: Dimens.FORTEEN,
              fontWeight: FontWeight.w500,
              color: AppColors.light_text,
              fontFamily: Strings.EXO_FONT,
            ),
          ),
        ),
        SizedBox(
          height: 32,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: _downloadButton(),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: _mainItemClick,
                    child: _mainItemBuilder(context, index));
              }),
        ),
      ],
    );
  }

  void _mainItemClick() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ComingUp()));
  }

  Widget _mainItemBuilder(BuildContext context, int index) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 20, top: 20, bottom: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'warm up',
              style: TextStyle(
                  letterSpacing: 1.04,
                  fontWeight: FontWeight.w600,
                  fontSize: Dimens.THRTEEN,
                  color: AppColors.unSelectedTextRadioColor,
                  fontFamily: Strings.EXO_FONT),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: Image.asset(
                    Images.DummyFood,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'warm up',
                      style: TextStyle(
                          letterSpacing: 1.04,
                          fontWeight: FontWeight.w600,
                          fontSize: Dimens.EIGHTEEN,
                          color: AppColors.black_text,
                          fontFamily: Strings.EXO_FONT),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'warm up',
                      style: TextStyle(
                          letterSpacing: 1.04,
                          fontWeight: FontWeight.w500,
                          fontSize: Dimens.FORTEEN,
                          color: AppColors.light_text,
                          fontFamily: Strings.EXO_FONT),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _downloadButton() {
    return Builder(
      builder: (context) => CustomRaisedButton(
        key: downloadWorkoutButtonKey,
        text: 'Download & start workout',
        backgroundColor: AppColors.pink_stroke,
        height: Dimens.SIXTY,
        width: MediaQuery.of(context).size.width,
        borderRadius: Dimens.THIRTY,
        onPressed: () {
          _downloadButtonPressed(context);
        },
        isGradient: true,
        loading: _isLoading,
        textStyle: TextStyle(
          fontSize: Dimens.FORTEEN,
          letterSpacing: 1.12,
          color: AppColors.white,
          fontWeight: FontWeight.w700,
          fontFamily: Strings.EXO_FONT,
        ),
      ),
    );
  }

  void _downloadButtonPressed(BuildContext context) {
    setState(() {
      _isLoading = _isLoading ? false : true;
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ComingUpNextWorkout()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        BackgroundWidgetWithImage(
          imagePath: Images.DummyFood,
          curveColor: AppColors.workoutDetail2BackColor,
        ),
        Scaffold(
          backgroundColor: AppColors.transparent,
          body: _isItemClick
              ? _callPages(_selectedIndex)
              : _WorkoutDetails2Widget(),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 10,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(Images.IconWorkouts)),
                title: Text(
                  '',
                ),
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(Images.IconMotivation)),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(Images.IconNutrition)),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(Images.IconWorkouts)),
                title: Text(''),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: AppColors.pink,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: _onItemTapped,
          ),
        ),
      ],
    );
  }
}
/*
*
*
*
*
* */
