import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../object/product_object.dart';

class ProductDetailModel extends ChangeNotifier {
  int productKey;
  late final Future<Box<Product>> _productBox;
  Product? _product;
  Product? get product => _product;

  ProductDetailModel({required this.productKey}) {
    _setup();
  }

  void showMenu(context) {
    Navigator.of(context).pop();
  }

  void _load() async {
    final box = await _productBox;
    _product = box.get(productKey);
    notifyListeners();
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ProductAdapter());
    }
    _productBox = Hive.openBox<Product>('products');
    _load();
  }

  toggFavorit() {
    _product?.isFavorite = !(_product!.isFavorite);
    _product?.save();
    notifyListeners();
  }
}
