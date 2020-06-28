import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:prankbros2/app/auth/forgotpassword/ForgotPassword.dart';
import 'package:prankbros2/app/auth/forgotpassword/SendEmail.dart';
import 'package:prankbros2/app/auth/intro/Intro.dart';
import 'package:prankbros2/app/auth/login/Login.dart';
import 'package:prankbros2/app/dashboard/Dashboard.dart';
import 'package:prankbros2/app/dashboard/custom_bottom_navigation_bar/CustomDashboardBottomNestedBar.dart';
import 'package:prankbros2/app/dashboard/workouts/WarmUpScreen.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/SizeConfig.dart';
import 'package:prankbros2/utils/Strings.dart';
import 'package:prankbros2/utils/Styling.dart';
import 'package:prankbros2/utils/locale/AppLanguage.dart';
import 'package:prankbros2/utils/locale/AppLocalizations.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SessionManager sessionManager = new SessionManager();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  sessionManager.isInstalledFirstTime().then((value) {
    print('value is ==>$value');
    if (value != null && value) {
      sessionManager.isLogin().then((value) {
        if (value != null && value) {
          runApp(MyApp(appLanguage, Strings.DASHBOARD_ROUTE));
        } else {
          runApp(MyApp(appLanguage, Strings.LOGIN_ROUTE));
        }
      });
//      runApp(MyApp(appLanguage, Login()));
    } else {
      runApp(MyApp(appLanguage, Strings.INTRO_ROUTE));
    }
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
//  final Widget startingWidget;
  final String startingWidget;
  final AppLanguage appLanguage;

  MyApp(this.appLanguage, this.startingWidget);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return ChangeNotifierProvider<AppLanguage>(
            create: (context) => appLanguage,
            child: Consumer<AppLanguage>(
              builder: (context, model, child) {
                return MaterialApp(
                  locale: model.appLocal,
                  supportedLocales: [
                    Locale('en', 'US'),
                    Locale('de', ''),
                  ],
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  title: "Prank bros",
                  debugShowCheckedModeBanner: false,
                  initialRoute: this.startingWidget,
                  routes: routes,
                  theme: appTheme,
                );
              },
            ),
          );
        });
      },
    );
  }

  var routes = <String, WidgetBuilder>{
    Strings.LOGIN_ROUTE: (BuildContext context) => new Login(),
    Strings.INTRO_ROUTE: (BuildContext context) => new Intro(),
    Strings.FORGOT_PASSWORD_ROUTE: (BuildContext context) => new ForgotPassword(),
    Strings.SEND_EMAIL_ROUTE: (BuildContext context) => new SendEmail(),
    Strings.DASHBOARD_ROUTE: (BuildContext context) => new Dashboard(),
    Strings.CUSTOM_DASHBOARD_ROUTE: (BuildContext context) => new CustomDashboardBottomNestedBar(),
    Strings.WARM_UP_ROUTE: (BuildContext context) => new WarmUpScreen(),
  };
}
