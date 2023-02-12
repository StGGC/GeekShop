import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/navigations/main_navigation.dart';

import 'package:text/ui/theme/theme_app.dart';

class MyAppWidget extends StatelessWidget {
  const MyAppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mainNavigation = MainNavigation();
    return Consumer<MyThemeNotifier>(
      builder: (context, themeModel, _) => MaterialApp(
        title: 'flutter app',
        theme: themeModel.getTheme,
        routes: mainNavigation.routes,
        initialRoute: mainNavigation.getRout,
        onGenerateRoute: mainNavigation.onGenerateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
