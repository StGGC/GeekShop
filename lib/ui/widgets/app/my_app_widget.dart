import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/navigations/main_navigation.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:text/ui/theme/theme_app.dart';

class MyAppWidget extends StatelessWidget {
  const MyAppWidget({Key? key}) : super(key: key);

  String getRout() {
    if (defaultTargetPlatform.name != 'windows') {
      if (FirebaseAuth.instance.currentUser != null) {
        return MainNavigationRouteName.main;
      } else {
        return MainNavigationRouteName.registrtation;
      }
    } else {
      return MainNavigationRouteName.main;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mainNavigation = MainNavigation();
    return Consumer<MyThemeNotifier>(
      builder: (context, themeModel, _) => MaterialApp(
        title: 'flutter app',
        theme: themeModel.getTheme(),
        // darkTheme: MyThemeNotifier.darkTheme,
        routes: mainNavigation.routes,
        initialRoute: getRout(),
        onGenerateRoute: mainNavigation.onGenerateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
