import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens/cart/cart_object_model.dart';

import '../../theme/theme_app.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(ThemeSize.kIndent),
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

    Widget addAndSub(int index) {
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

    Widget imgItemCart(String? img) {
      return Image(image: NetworkImage(img as String));
    }

    final _ = model.listCarts.values.toList()[index].product;
    return Container(
      color: Colors.teal,
      child: ListTile(
          minVerticalPadding: 2.5,
          leading: imgItemCart(_.imgUrl),
          title: Text(_.name as String),
          subtitle: Text('${_.price}'),
          trailing: addAndSub(index)),
    );
  }
}

class _CartBody extends StatelessWidget {
  const _CartBody();
  @override
  Widget build(BuildContext context) {
    final model = context.watch<CartModel>();
    return Expanded(
        child: ListView.separated(
      itemCount: model.listCarts.values.toList().length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => model.showDetail(
              context, model.listCarts.values.toList()[index].product),
          child: _ItemCart(index: index),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 10,
      ),
    ));
  }
}

class _CartButtomBar extends StatelessWidget {
  const _CartButtomBar();
  @override
  Widget build(BuildContext context) {
    final model = context.watch<CartModel>();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).splashColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(ThemeSize.kRadius),
        ),
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Общая цена ${model.pr}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            model.pr > 20000
                ? Text(
                    'Скидка -${model.procent}',
                    style: const TextStyle(color: Colors.greenAccent),
                  )
                : const SizedBox.shrink(),
            Text('Цена со скидкой ${model.total}'),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(7.0),
                margin: const EdgeInsets.only(left: 10),
                decoration: const BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Center(child: Text('Оплата')),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
