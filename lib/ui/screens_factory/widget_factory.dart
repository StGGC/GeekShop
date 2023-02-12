import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens/profile/profile_model.dart';
import 'package:text/ui/screens/cart/cart_object_model.dart';
import 'package:text/ui/screens/detail/product_detail_screen.dart';
import 'package:text/ui/screens/favorite/favorite_model.dart';
import 'package:text/ui/screens/favorite/favorite_screen.dart';
import '../../object/product_model.dart';
import '../screens/profile/profile.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/guiding_screen/guiding_model.dart';
import '../screens/guiding_screen/guiding_screen.dart';
import '../screens/menu_home_screen/menu_home_model.dart';
import '../screens/menu_home_screen/menu_home_screen.dart';
import '../screens/registr/registr_screen.dart';
import '../screens/registr/registr_screen_model.dart';
import '../theme/theme_app.dart';
import '../widgets/app/my_app_widget.dart';
import '../widgets/app/splashload.dart';

class ScreensFactory {
  Widget makeGuiding() => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GuidingScreenModel()),
          ChangeNotifierProvider(create: (_) => ProductModel()),
          ChangeNotifierProvider(create: (_) => CartModel()),
        ],
        child: const GuidingScreen(),
      );

  /////// основные страницы  ///////
  Widget initScreen() => ChangeNotifierProvider(
        create: (_) => MyThemeNotifier(),
        child: const MyAppWidget(),
      );
  Widget makeMenuHome() => ChangeNotifierProvider(
        create: (_) => MenuHomeModel(),
        child: const MenuHomeScreen(),
      );

  Widget makeDetailed() => const ProductDetailScreen();
  Widget makeCart() => const CartScreen();
  Widget makeLoad() => const CircularLoad();
  Widget makeProfile() => ChangeNotifierProvider(
        create: (_) => ProfileModel(),
        child: const ProfileScreen(),
      );
  Widget makeRegistration() => ChangeNotifierProvider(
        create: (_) => RegistrModel(),
        child: const RegistrationScreen(),
      );
  Widget makeFavorite() => ChangeNotifierProvider(
        create: (_) => FavoriteModel(),
        child: const FavoriteScreen(),
      );
}
