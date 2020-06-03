import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:prankbros2/app/auth/intro/Intro.dart';
import 'package:prankbros2/app/auth/login/Login.dart';
import 'package:prankbros2/utils/SessionManager.dart';
import 'package:prankbros2/utils/SizeConfig.dart';
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
      runApp(MyApp(appLanguage, Login()));
    } else {
      runApp(MyApp(appLanguage, Intro()));
    }
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Widget startingWidget;
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
                  home: this.startingWidget,
                  theme: appTheme,
                );
              },
            ),
          );
        });
      },
    );
  }
}
