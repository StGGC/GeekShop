import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:text/object/product_object.dart';
import 'package:text/ui/navigations/main_navigation.dart';
import 'cart_object.dart';

class CartModel extends ChangeNotifier {
  void showDetail(BuildContext context, ProductData item) {
    Navigator.of(context)
        .pushNamed(MainNavigationRouteName.details, arguments: item.key);
  }

  final Map<String, Cart> _listCarts = {};
  UnmodifiableMapView<String, Cart> get listCarts =>
      UnmodifiableMapView(_listCarts);

  double get pr => _pr;
  double get total => _total;

  String get number => allNumber();

  allNumber() {
    var number = 0;
    _listCarts.forEach((key, value) {
      number += value.count;
    });
    return number.toString();
  }

  void cartAdd({required ProductData product}) {
    if (_listCarts.containsKey(product.id)) {
      _listCarts.update(
        product.id!,
        (value) => Cart(
          id: value.id,
          count: value.count + 1,
          product: value.product,
        ),
      );
    } else {
      _listCarts.putIfAbsent(
          product.id!,
          () => Cart(
                id: '${DateTime.now()}',
                count: 1,
                product: product,
              ));
    }
    allTotal();
    notifyListeners();
  }

  void deleteItem({productId}) {
    _listCarts.remove(productId);
    allTotal();
    notifyListeners();
  }

  void updateAddOne({productId}) {
    _listCarts.update(
        productId,
        (value) =>
            Cart(id: value.id, count: value.count + 1, product: value.product));
    allTotal();

    notifyListeners();
  }

  void updateDeleteOne({required cartKey}) {
    if ((_listCarts[cartKey]?.count ?? 0) < 2) {
      deleteItem(productId: cartKey);
    } else {
      _listCarts.update(
          cartKey,
          (value) => Cart(
              id: value.id, count: value.count - 1, product: value.product));
    }
    allTotal();

    notifyListeners();
  }

  double _pr = 0;
  double procent = 0;
  double _total = 0;
  void allTotal() {
    _pr = 0;
    procent = 0;
    _total = 0;
    _listCarts.forEach((key, value) {
      _pr += value.product.price! * value.count;
    });
    if (_pr > 20000) {
      procent = _pr / 100 * 10;
    } else {
      procent = 0;
    }
    _total = _pr - procent;
  }
}
