import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/custom_bottom_navigation_bar/CustomBottomNavigationBar.dart';
import 'package:prankbros2/app/dashboard/motivation/Motivation.dart';
import 'package:prankbros2/app/dashboard/workouts/ComingUp.dart';
import 'package:prankbros2/app/dashboard/workouts/WorkoutDetails.dart';
import 'package:prankbros2/app/dashboard/workouts/WorkoutDetails2.dart';
import 'package:prankbros2/app/dashboard/workouts/Workouts.dart';

class MotivationTabNavigatorRoutes {
  static const String motivation_root = '/Motivation';
}

class MotivationTabNavigator extends StatelessWidget {
  MotivationTabNavigator({this.navigatorKey, this.tabItem});

  final GlobalKey<NavigatorState> navigatorKey;
  final BottomBarItem tabItem;

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      MotivationTabNavigatorRoutes.motivation_root: (context) => Motivation(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: MotivationTabNavigatorRoutes.motivation_root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[
          routeSettings.name == null || routeSettings.name == '/'
              ? MotivationTabNavigatorRoutes.motivation_root
              : routeSettings.name](context),
        );
      },
    );
  }
}
