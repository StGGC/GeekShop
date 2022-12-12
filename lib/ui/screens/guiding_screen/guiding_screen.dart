import 'package:bottom_nav_bar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens/cart/cart_object_model.dart';
import 'package:text/ui/theme/theme_app.dart';
import '../profile/profile.dart';
import '../../screens_factory/widget_factory.dart';
import 'guiding_model.dart';

class GuidingScreen extends StatelessWidget {
  const GuidingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    return Scaffold(
      body: const _GuidingBodyWidget(),
      floatingActionButton:
          (mediaQuery < 371) ? const _FooterFlotingButtom() : null,
      bottomNavigationBar:
          (mediaQuery >= 371) ? const _FooterBottomBarWidget() : null,
      backgroundColor: ThemeApp.kBGColor,
    );
  }
}

class _GuidingBodyWidget extends StatelessWidget {
  const _GuidingBodyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final currentIndexTab =
        context.select((GuidingScreenModel e) => e.currentIndexTab);
    return SafeArea(
      child: IndexedStack(
        index: currentIndexTab,
        children: [
          ScreensFactory().makeMenuHome(),
          ScreensFactory().makeFavorite(),
          ScreensFactory().makeCart(),
          ScreensFactory().makeProfile(),
        ],
      ),
    );
  }
}

class _FooterBottomBarWidget extends StatelessWidget {
  const _FooterBottomBarWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final currentIndexTab =
        context.select((GuidingScreenModel e) => e.currentIndexTab);
    final model = context.read<GuidingScreenModel>();
    final cartModel = context.watch<CartModel>();
    return BottomNavBar(
      showElevation: true,
      itemCornerRadius: 20,
      selectedIndex: currentIndexTab,
      containerPadding: EdgeInsets.zero,
      backgroundColor: ThemeApp.kBGColor,
      onItemSelected: model.setCurrentIndexTab,
      animationDuration: const Duration(milliseconds: 300),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      items: <BottomNavBarItem>[
        bubbItem('Home', Icons.home, currentIndexTab),
        bubbItem('Favorite', Icons.favorite, currentIndexTab),
        BottomNavBarItem(
          title: 'Shop cart',
          icon: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_cart),
              cartModel.listCarts.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        cartModel.number,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
          inactiveColor: ThemeApp.kFrontColor,
          activeColor: Color(listIntActiveColor[currentIndexTab]),
          activeBackgroundColor: ThemeApp.kFrontColor,
        ),
        bubbItem('Profile', Icons.account_circle_rounded, currentIndexTab),
      ],
    );
  }
}

class _FooterFlotingButtom extends StatelessWidget {
  const _FooterFlotingButtom({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 33,
      backgroundColor: ThemeApp.kFrontColor,
      child: Center(
        child: FloatingActionButton(
          elevation: 0,
          onPressed: () {},
          backgroundColor: ThemeApp.kAccent,
          child: const Icon(Icons.menu_sharp),
        ),
      ),
    );
  }
}

final listIntActiveColor = [0xffF10f2f10, 0xffFF3D00, 0xffF10f2f10, 0xffF7fff6];
bubbItem(String text, IconData icon, int index) {
  return BottomNavBarItem(
    title: text,
    icon: Icon(icon),
    inactiveColor: ThemeApp.kFrontColor,
    activeColor: Color(listIntActiveColor[index]),
    activeBackgroundColor: ThemeApp.kFrontColor,
  );
}
