import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/utils/AppColors.dart';
import 'package:prankbros2/utils/Images.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';

enum BottomBarItem { WORKOUTS, MOTIVATION, NUTRITION, SETTINGS }


class BottomBarNavigation extends StatelessWidget {
  BottomBarNavigation({this.currentTab, this.onSelectTab});

  final BottomBarItem currentTab;
  final ValueChanged<BottomBarItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      items: [
        _buildItem(tabItem: BottomBarItem.WORKOUTS),
        _buildItem(tabItem: BottomBarItem.MOTIVATION),
        _buildItem(tabItem: BottomBarItem.NUTRITION),
        _buildItem(tabItem: BottomBarItem.SETTINGS),
      ],
      onTap: (index) => onSelectTab(
        BottomBarItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem({BottomBarItem tabItem}) {
//    String text = bottomBarItemName[tabItem];
    var icon = ImageIcon(AssetImage(Images.IconWorkouts));

    switch (tabItem.index) {
      case 0:
        {
          icon = ImageIcon(
            AssetImage(
              Images.IconWorkouts,
            ),
            color: currentTab == tabItem ? AppColors.pink : Colors.grey,
          );
        }
        break;
      case 1:
        {
          icon = ImageIcon(
            AssetImage(Images.IconMotivation),
            color: currentTab == tabItem ? AppColors.pink : Colors.grey,
          );
        }
        break;
      case 2:
        {
          icon = ImageIcon(
            AssetImage(Images.IconNutrition),
            color: currentTab == tabItem ? AppColors.pink : Colors.grey,
          );
        }
        break;
      case 3:
        {
          icon = ImageIcon(
            AssetImage(Images.IconWorkouts),
            color: currentTab == tabItem ? AppColors.pink : Colors.grey,
          );
        }
        break;
    }

    return BottomNavigationBarItem(
      icon: icon,
      title: Text(
        '',
      ),
    );
  }
}
