import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/custom_bottom_navigation_bar/CustomBottomNavigationBar.dart';
import 'package:prankbros2/app/dashboard/nutrition/Nutrition.dart';
import 'package:prankbros2/app/dashboard/profile/Profile.dart';

class SettingsTabNavigatorRoutes {
  static const String settings_root = '/Settings';
}

class SettingsTabNavigator extends StatelessWidget {
  SettingsTabNavigator({this.navigatorKey, this.tabItem});

  final GlobalKey<NavigatorState> navigatorKey;
  final BottomBarItem tabItem;

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      SettingsTabNavigatorRoutes.settings_root: (context) => Profile(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: SettingsTabNavigatorRoutes.settings_root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[
              routeSettings.name == null || routeSettings.name == '/'
                  ? SettingsTabNavigatorRoutes.settings_root
                  : routeSettings.name](context),
        );
      },
    );
  }
}
