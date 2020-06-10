import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prankbros2/app/dashboard/custom_bottom_navigation_bar/CustomBottomNavigationBar.dart';
import 'package:prankbros2/app/dashboard/nutrition/Nutrition.dart';
import 'package:prankbros2/app/dashboard/nutrition/NutritionDetail.dart';

class NutritionTabNavigatorRoutes {
  static const String nutrition_root = '/Nutrition';
  static const String nutrition_detail = '/NutritionDetail';
}

class NutritionTabNavigator extends StatelessWidget {
  NutritionTabNavigator({this.navigatorKey, this.tabItem});

  final GlobalKey<NavigatorState> navigatorKey;
  final BottomBarItem tabItem;

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      NutritionTabNavigatorRoutes.nutrition_root: (context) => Nutrition(
            onPush: (materialIndex) => _pushNutritionDetail(context),
          ),
      NutritionTabNavigatorRoutes.nutrition_detail: (context) =>
          NutritionDetail(),
    };
  }

  void _pushNutritionDetail(BuildContext context) {
    var routeBuilders = _routeBuilders(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            routeBuilders[NutritionTabNavigatorRoutes.nutrition_detail](
                context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: NutritionTabNavigatorRoutes.nutrition_root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[
              routeSettings.name == null || routeSettings.name == '/'
                  ? NutritionTabNavigatorRoutes.nutrition_root
                  : routeSettings.name](context),
        );
      },
    );
  }
}
