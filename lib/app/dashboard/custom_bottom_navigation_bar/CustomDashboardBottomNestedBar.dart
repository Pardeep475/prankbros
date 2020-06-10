import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/custom_bottom_navigation_bar/MotivationTabNavigatorRoute.dart';
import 'package:prankbros2/app/dashboard/custom_bottom_navigation_bar/NutiritionTabNavigatorRoute.dart';
import 'package:prankbros2/app/dashboard/custom_bottom_navigation_bar/SettingsTabNavigatorRoute.dart';
import 'package:prankbros2/app/dashboard/custom_bottom_navigation_bar/WorkoutsTabNavigatorRoute.dart';

import 'CustomBottomNavigationBar.dart';

class CustomDashboardBottomNestedBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      new _CustomDashboardBottomNestedBarState();
}

class _CustomDashboardBottomNestedBarState
    extends State<CustomDashboardBottomNestedBar> {
  BottomBarItem _currentTab = BottomBarItem.WORKOUTS;

  Map<BottomBarItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    BottomBarItem.WORKOUTS: GlobalKey<NavigatorState>(),
    BottomBarItem.MOTIVATION: GlobalKey<NavigatorState>(),
    BottomBarItem.NUTRITION: GlobalKey<NavigatorState>(),
    BottomBarItem.SETTINGS: GlobalKey<NavigatorState>(),
  };

  void _selectTab(BottomBarItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != BottomBarItem.WORKOUTS) {
            // select 'main' tab
            _selectTab(BottomBarItem.WORKOUTS);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildWorkoutOffstageNavigator(BottomBarItem.WORKOUTS),
          _buildMotivationOffstageNavigator(BottomBarItem.MOTIVATION),
          _buildNutritionOffstageNavigator(BottomBarItem.NUTRITION),
          _buildSettingsOffstageNavigator(BottomBarItem.SETTINGS),
        ]),
        bottomNavigationBar: BottomBarNavigation(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  Widget _buildWorkoutOffstageNavigator(BottomBarItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: WorkoutTabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

  Widget _buildMotivationOffstageNavigator(BottomBarItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: MotivationTabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

  Widget _buildNutritionOffstageNavigator(BottomBarItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: NutritionTabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

  Widget _buildSettingsOffstageNavigator(BottomBarItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: SettingsTabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
