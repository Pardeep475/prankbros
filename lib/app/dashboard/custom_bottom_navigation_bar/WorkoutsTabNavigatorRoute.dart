import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/custom_bottom_navigation_bar/CustomBottomNavigationBar.dart';
import 'package:prankbros2/app/dashboard/workouts/ComingUp.dart';
import 'package:prankbros2/app/dashboard/workouts/WorkoutDetails.dart';
import 'package:prankbros2/app/dashboard/workouts/WorkoutDetails2.dart';
import 'package:prankbros2/app/dashboard/workouts/Workouts.dart';

class WorkoutTabNavigatorRoutes {
  static const String workout_root = '/';
  static const String workout_detail_root = '/WorkoutDetails';
  static const String workout_detail2_root = '/WorkoutDetails2';
  static const String coming_up_root = '/ComingUp';
}

class WorkoutTabNavigator extends StatelessWidget {
  WorkoutTabNavigator({this.navigatorKey, this.tabItem});

  final GlobalKey<NavigatorState> navigatorKey;
  final BottomBarItem tabItem;

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      WorkoutTabNavigatorRoutes.workout_root: (context) => Workouts(
            onPush: (value) => _pushWorkoutDetail(context),
          ),
      WorkoutTabNavigatorRoutes.workout_detail_root: (context) =>
          WorkoutDetails(
            onPush: (value) => _pushWorkoutDetail2(context),
          ),
      WorkoutTabNavigatorRoutes.workout_detail2_root: (context) =>
          WorkoutDetails2(
            onPush: (value) => _pushComingUp(context),
          ),
      WorkoutTabNavigatorRoutes.coming_up_root: (context) => ComingUp(),
    };
  }

  void _pushWorkoutDetail(BuildContext context) {
    var routeBuilders = _routeBuilders(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            routeBuilders[WorkoutTabNavigatorRoutes.workout_detail_root](
                context),
      ),
    );
  }

  void _pushWorkoutDetail2(BuildContext context) {
    var routeBuilders = _routeBuilders(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            routeBuilders[WorkoutTabNavigatorRoutes.workout_detail2_root](
                context),
      ),
    );
  }

  void _pushComingUp(BuildContext context) {
    var routeBuilders = _routeBuilders(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            routeBuilders[WorkoutTabNavigatorRoutes.coming_up_root](context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: WorkoutTabNavigatorRoutes.workout_root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[
              routeSettings.name == null || routeSettings.name == '/'
                  ? WorkoutTabNavigatorRoutes.workout_root
                  : routeSettings.name](context),
        );
      },
    );
  }
}
