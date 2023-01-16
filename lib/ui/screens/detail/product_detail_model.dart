import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../object/product_object.dart';

class ProductDetailModel extends ChangeNotifier {
  int productKey;
  late final Future<Box<ProductData>> _productBox;
  ProductData? _product;
  ProductData? get product => _product;

  ProductDetailModel({required this.productKey}) {
    _setup();
  }

  void showMenu(context) {
    Navigator.of(context).pop();
  }

  Future<void> _load() async {
    final box = await _productBox;
    _product = box.get(productKey);
    notifyListeners();
  }

  Future<void> _setup() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ProductDataAdapter());
    }
    _productBox = Hive.openBox<ProductData>('products');
    await _load();
  }

  toggFavorit() {
    _product?.isFavorite = !(_product!.isFavorite!);
    _product?.save();
    notifyListeners();
  }
}
