import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text/ui/navigations/main_navigation.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MyAppWidget extends StatelessWidget {
  const MyAppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mainNavigation = MainNavigation();
    return MaterialApp(
      title: 'flutter app',
      theme: ThemeData(),
      routes: mainNavigation.routes,
      initialRoute: _auth.currentUser == null
          ? MainNavigationRouteName.registrtation
          : MainNavigationRouteName.main,
      onGenerateRoute: mainNavigation.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
