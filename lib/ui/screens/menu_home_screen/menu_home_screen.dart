import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/dep/deb.dart';
import 'package:text/ui/screens/cart/cart_object_model.dart';
import '../../../object/product_model.dart';
import '../../theme/theme_app.dart';
import '../../widgets/header_widget/header_widget.dart';

class MenuHomeScreen extends StatelessWidget {
  const MenuHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    final model = context.watch<ProductModel>();

    return Column(
      children: mediaQuery < 370
          ? [const _MenuBodyWidget()]
          : [const HomeHederWidget(), const _MenuBodyWidget()],
    );
  }
}

class _MenuBodyWidget extends StatelessWidget {
  const _MenuBodyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final product = context.watch<ProductModel>().itemsFilter;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(ThemeSize.kIndent),
        child: GridView.builder(
          itemCount: product.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisSpacing: ThemeSize.kIndent,
            crossAxisSpacing: ThemeSize.kIndent,
            maxCrossAxisExtent: 335.0,
          ),
          itemBuilder: (context, index) => (product.isNotEmpty)
              ? _CartItemWidget(index: index)
              : const _ListIsEmpty(),
        ),
      ),
    );
  }
}

class _CartItemWidget extends StatelessWidget {
  const _CartItemWidget({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context).size.width;

    final product = context.watch<ProductModel>();
    return GestureDetector(
      onTap: () => product.showDetail(context, product.itemsFilter[index]),
      child: _CartItemContainerWidget(index: index),
    );
  }
}

class _CartItemContainerWidget extends StatelessWidget {
  const _CartItemContainerWidget({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    // final itemImgUrl = context.read<ProductModel>().items[index].imgUrl;
    return DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).splashColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(ThemeSize.kRadius),
          ),
        ),
        child: _CartItemContainerContentWidget(index: index));
  }
}

class _CartItemContainerContentWidget extends StatelessWidget {
  const _CartItemContainerContentWidget({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //_CartItemButtonTovarAddWidget(index: index),
        _CartItemContainerTextWidget(index: index),
      ],
    );
  }
}

// class _CartItemButtonTovarAddWidget extends StatelessWidget {
//   const _CartItemButtonTovarAddWidget({required this.index});
//   final int index;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ElevatedButton(
//             onPressed: (() {}), child: const Icon(Icons.shopping_cart))
//       ],
//     );
//   }
// }

class _CartItemContainerTextWidget extends StatelessWidget {
  const _CartItemContainerTextWidget({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final product = context.watch<ProductModel>();
    final cart = context.watch<CartModel>();
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(ThemeSize.kRadius),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    product.itemsFilter[index].imgUrl as String,
                  ),
                  fit: BoxFit.contain,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 219, 219, 229),
                    blurRadius: 10.0,
                    spreadRadius: 0.3,
                    offset: Offset(2, 3),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: ThemeSize.kIndent),
          Padding(
            padding: const EdgeInsets.only(
              left: ThemeSize.kIndent,
              right: ThemeSize.kIndent,
              bottom: ThemeSize.kIndent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.itemsFilter[index].name as String,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${product.items[index].price} Р.',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 2,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        cart.cartAdd(product: product.items[index]);
                      },
                      child: Icon(
                        Icons.add_circle_outline,
                        size: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class _CartItemImgWidget extends StatelessWidget {
//   const _CartItemImgWidget({Key? key, required this.index}) : super(key: key);
//   final int index;
//   @override
//   Widget build(BuildContext context) {
//     final itemImgUrl = context.read<ProductModel>().items[index].imgUrl;
//     return Positioned(
//       child: Image.asset(
//         itemImgUrl,
//         fit: BoxFit.cover,
//         width: 100,
//       ),
//     );
//   }
// }

class _ListIsEmpty extends StatelessWidget {
  const _ListIsEmpty({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Пусто '),
    );
  }
}
