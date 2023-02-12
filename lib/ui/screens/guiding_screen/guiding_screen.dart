import 'package:bottom_nav_bar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens/cart/cart_object_model.dart';
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        onItemSelected: model.setCurrentIndexTab,
        animationDuration: const Duration(milliseconds: 300),
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        items: List.generate(
          menuIcon.length,
          (index) => bubbItem(index, context, cartModel),
        ));
  }
}

class _FooterFlotingButtom extends StatelessWidget {
  const _FooterFlotingButtom({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<GuidingScreenModel>();
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      if (model.menuVisibility)
        ...List.generate(menuIcon.length, (index) => _MenuButton(index: index)),
      const FloatingButton(),
    ]);
  }
}

final listIntActiveColor = [0xffF10f2f10, 0xffFF3D00, 0xffF10f2f10, 0xffF7fff6];

bubbItem(int index, context, CartModel cartModel) {
  return BottomNavBarItem(
    title: menuName[index],
    icon: menuName[index] != 'Корзина'
        ? Icon(menuIcon[index])
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_cart),
              cartModel.listCarts.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        cartModel.number,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
    inactiveColor: Theme.of(context).splashColor,
    activeColor: Color(listIntActiveColor[index]),
    activeBackgroundColor: Theme.of(context).splashColor,
  );
}

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});
  @override
  Widget build(BuildContext context) {
    final model = context.read<GuidingScreenModel>();
    return FloatingActionButton(
      elevation: 0,
      onPressed: () => model.toggMeniVisibility(),
      backgroundColor: Theme.of(context).primaryColor,
      child: const Icon(size: 25, Icons.menu_sharp),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final int index;
  const _MenuButton({required this.index});
  @override
  Widget build(BuildContext context) {
    final model = context.read<GuidingScreenModel>();
    double size = 50.0;
    return InkWell(
      onTap: () => model.setCurrentIndexTab(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(size / 2),
          ),
        ),
        child: Icon(
          menuIcon[index],
          color: Color(listIntActiveColor[index]),
        ),
      ),
    );
  }
}

List menuIcon = <IconData>[
  Icons.home,
  Icons.favorite,
  Icons.shopping_cart,
  Icons.account_circle
];
List menuName = <String>[
  'Главная',
  'Фавориты',
  'Корзина',
  'Профиль',
];

class MenuData {
  final String name;
  final IconData icon;
  MenuData({
    required this.icon,
    required this.name,
  });
}
