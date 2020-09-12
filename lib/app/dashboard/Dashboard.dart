import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/profile/Profile.dart';
import 'package:prankbros2/app/dashboard/workouts/Workouts.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Images.dart';

import 'motivation/Motivation.dart';
import 'nutrition/Nutrition.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  List<Widget> screens = new List<Widget>.generate(4, (index) {
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
  });

  @override
  _BottomNavigationBarItem createState() => _BottomNavigationBarItem();
}

class _BottomNavigationBarItem extends State<Dashboard> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
//      body: _callPages(_selectedIndex),

      body: IndexedStack(
        index: _selectedIndex,
        children: widget.screens,
      ),

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
            icon: ImageIcon(AssetImage(Images.ICON_PROFILE)),
            title: Text(''),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.pink,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }
}
