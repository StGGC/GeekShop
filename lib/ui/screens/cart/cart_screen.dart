import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens/cart/cart_object_model.dart';

import '../../../object/product_model.dart';
import '../../../object/product_object.dart';
import '../../theme/theme_app.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(ThemeApp.kIndent),
      child: Column(
        children: const [
          _CartBody(),
          _CartButtomBar(),
        ],
      ),
    );
  }
}

class _ItemCart extends StatelessWidget {
  final int index;
  const _ItemCart({required this.index});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CartModel>();

    Widget _addAndSub(int index) {
      return FittedBox(
        child: Column(
          children: [
            InkWell(
              onTap: () => model.deleteItem(
                  productId: model.listCarts.keys.toList()[index]),
              child: Icon(Icons.delete, color: Colors.red.shade800),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () => model.updateAddOne(
                      productId: model.listCarts.keys.toList()[index]),
                  child: const Icon(Icons.add),
                ),
                Text(model.listCarts.values.toList()[index].count.toString()),
                InkWell(
                  onTap: () => model.updateDeleteOne(
                      cartKey: model.listCarts.keys.toList()[index]),
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget _imgItemCart(String? img) {
      return Image(image: AssetImage(img ?? 'assets/imgs/Prod1.png'));
    }

    final _ = model.listCarts.values.toList()[index].product;
    return Container(
      color: Colors.teal,
      child: ListTile(
          minVerticalPadding: 2.5,
          leading: _imgItemCart(_.imgUrl),
          title: Text(_.name),
          subtitle: Text('${_.price}'),
          trailing: _addAndSub(index)),
    );
  }
}

class _CartBody extends StatelessWidget {
  const _CartBody();
  @override
  Widget build(BuildContext context) {
    final model = context.watch<CartModel>();
    return Expanded(
      child: ListView.builder(
        itemCount: model.listCarts.values.toList().length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => model.showDetail(
                context, model.listCarts.values.toList()[index].product),
            child: _ItemCart(index: index),
          );
        },
      ),
    );
  }
}

class _CartButtomBar extends StatelessWidget {
  const _CartButtomBar();
  @override
  Widget build(BuildContext context) {
    final model = context.watch<CartModel>();
    return Container(
      decoration: const BoxDecoration(
        color: ThemeApp.kFrontColor,
        borderRadius: BorderRadius.all(
          Radius.circular(ThemeApp.kRadius),
        ),
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('all total ${model.pr}'),
            model.pr > 20000
                ? Text(
                    'save -${model.procent}',
                    style: const TextStyle(color: Colors.green),
                  )
                : const SizedBox.shrink(),
            Text('total ${model.total}'),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(7.0),
                margin: const EdgeInsets.only(left: 10),
                decoration: const BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Center(child: Text('Pay')),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
