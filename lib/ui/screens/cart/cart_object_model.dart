import 'dart:collection';

import 'package:flutter/material.dart';

import 'cart_object.dart';

class CartModel extends ChangeNotifier {
  Map<String, Cart> _listCarts = {};
  UnmodifiableMapView<String, Cart> get listCarts =>
      UnmodifiableMapView(_listCarts);

  double get pr => _pr;
  double get total => _total;
  var _number;
  String get number => allNumber();

  allNumber() {
    _number = 0;
    _listCarts.forEach((key, value) {
      _number += value.count;
    });
    return _number.toString();
  }

  void cartAdd({productId, price, name, imgUrl}) {
    if (_listCarts.containsKey(productId)) {
      _listCarts.update(
        productId,
        (value) => Cart(
          id: value.id,
          count: value.count + 1,
          name: value.name,
          imgUrl: value.imgUrl,
          price: value.price,
        ),
      );
    } else {
      _listCarts.putIfAbsent(
          productId,
          () => Cart(
              id: '${DateTime.now()}',
              count: 1,
              name: name,
              imgUrl: imgUrl,
              price: price));
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
        (value) => Cart(
            id: value.id,
            count: value.count + 1,
            name: value.name,
            imgUrl: value.imgUrl,
            price: value.price));
    allTotal();

    notifyListeners();
  }

  void updateDeleteOne({productId}) {
    if ((_listCarts[productId]?.count ?? 0) < 2) {
      deleteItem(productId: productId);
    } else {
      _listCarts.update(
          productId,
          (value) => Cart(
              id: value.id,
              count: value.count - 1,
              name: value.name,
              imgUrl: value.imgUrl,
              price: value.price));
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
      _pr += value.price * value.count;
    });
    if (_pr > 20000) {
      procent = _pr / 100 * 10;
    } else {
      procent = 0;
    }
    _total = _pr - procent;
  }
}
