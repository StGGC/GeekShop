import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens/cart/cart_object_model.dart';

import '../../theme/theme_app.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CartModel>();
    final length = model.listCarts.values.toList().length;
    final prs = model.pr;
    final proc = model.procent.toStringAsFixed(0);
    final total = model.total;
    return Padding(
      padding: const EdgeInsets.all(ThemeApp.kIndent),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: length,
              shrinkWrap: true,
              itemBuilder: (context, index) => _ItemCartWidget(index: index),
            ),
          ),
          Container(
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('all total '),
                          Text('$prs'),
                        ],
                      ),
                      Row(
                          children: prs > 20000
                              ? [
                                  Text('save '),
                                  Text(
                                    '-' + proc,
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                ]
                              : []),
                    ],
                  ),
                  Row(
                    children: [
                      Text('total '),
                      Text(total.toString()),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const SizedBox(
                        width: double.infinity,
                        child: Center(child: Text('Pay'))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemCartWidget extends StatelessWidget {
  const _ItemCartWidget({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartModel>();
    final items = cart.listCarts.values.toList();
    final item = cart.listCarts.keys.toList()[index];
    return Card(
      color: ThemeApp.kFrontColor,
      elevation: .0,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image(
                height: 80, width: 80, image: AssetImage(items[index].imgUrl)),
            SizedBox(
              width: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5.0,
                  ),
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    text: TextSpan(
                        text: 'Name: ',
                        style: TextStyle(
                            color: Colors.blueGrey.shade800, fontSize: 16.0),
                        children: [
                          TextSpan(
                              text: items[index].name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ]),
                  ),
                  RichText(
                    maxLines: 1,
                    text: TextSpan(
                        text: 'Price: ',
                        style: TextStyle(
                            color: Colors.blueGrey.shade800, fontSize: 16.0),
                        children: [
                          TextSpan(
                              text: items[index].price.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ]),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    cart.deleteItem(productId: item);
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red.shade800,
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        cart.updateAddOne(productId: item);
                      },
                      child: const Icon(Icons.add),
                    ),
                    Text(items[index].count.toString()),
                    GestureDetector(
                      onTap: () {
                        cart.updateDeleteOne(productId: item);
                      },
                      child: const Icon(Icons.remove),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
