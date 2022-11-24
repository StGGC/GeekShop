import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../object/product_object.dart';

class FavoriteModel extends ChangeNotifier {
  FavoriteModel() {
    _op();
  }
  final _itemsfavorite = <Product>[];
  List<Product> get items => _itemsfavorite.toList();

  void _loadFavorit(box) {
    for (var element in box.values) {
      if (element.isFavorite && !_itemsfavorite.contains(element)) {
        _itemsfavorite.add(element);
      } else if (!element.isFavorite) {
        _itemsfavorite.remove(element);
      }
    }
    notifyListeners();
  }

  void _op() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ProductAdapter());
    }
    final box = await Hive.openBox<Product>('products');
    _loadFavorit(box);
    box.listenable().addListener(() {
      _loadFavorit(box);
    });
  }

  void justdelfavorite(item) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ProductAdapter());
    }
    final box = await Hive.openBox<Product>('products');
    for (var element in box.values) {
      if (element == item) {
        item?.isFavorite = false;
      }
    }
    item?.save();
    notifyListeners();
  }
}
