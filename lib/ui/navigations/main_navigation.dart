import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens_factory/widget_factory.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;

abstract class MainNavigationRouteName {
  static const main = '/';
  static const details = '/details';
  static const cart = '/cart';
  static const favorite = '/favor';
  static const registrtation = '/registr';
  static const load = '/load';
  static const profile = '/profile';
}

class MainNavigation {
  final _widgetFactory = ScreensFactory();
  final initialRoute = MainNavigationRouteName.main;
  final details = MainNavigationRouteName.details;
  final cart = MainNavigationRouteName.cart;
  final favorite = MainNavigationRouteName.favorite;
  final registration = MainNavigationRouteName.registrtation;
  final load = MainNavigationRouteName.load;
  final profile = MainNavigationRouteName.profile;
  Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        initialRoute: (_) => _widgetFactory.makeGuiding(),
        details: (_) => _widgetFactory.makeDetailed(),
        cart: (_) => _widgetFactory.makeCart(),
        favorite: (_) => _widgetFactory.makeFavorite(),
        registration: (_) => _widgetFactory.makeRegistration(),
        load: (_) => _widgetFactory.makeLoad(),
        profile: (_) => _widgetFactory.makeProfile(),
      };
  String get getRout {
    if (defaultTargetPlatform.name != 'windows') {
      if (FirebaseAuth.instance.currentUser != null) {
        return MainNavigationRouteName.main;
      } else {
        return MainNavigationRouteName.registrtation;
      }
    }
    return MainNavigationRouteName.main;
  }

  Route? onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(child: Text('ошибка навигации ! , ${settings.name}')),
      ),
    );
  }
}
