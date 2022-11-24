import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:text/object/product_object.dart';

import '../ui/navigations/main_navigation.dart';

class ProductModel extends ChangeNotifier {
  void showDetail(BuildContext context, Product item) {
    Navigator.of(context)
        .pushNamed(MainNavigationRouteName.details, arguments: item.key);
  }

  var _items = <Product>[];
  List<Product> get items => _items.toList();
  List<Product> get itemsFilter => _itemsFilter.toList();
  var _itemsFilter = <Product>[];
  ProductModel() {
    _setup();
  }
  void _readFromHive(Box<Product> box) {
    _items = box.values.toList();
    _itemsFilter = _items;
    notifyListeners();
  }

  void justFilter(String text) {
    if (text.isNotEmpty) {
      _itemsFilter = [];
      _itemsFilter = _items
          .where((element) =>
              element.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    } else {
      _itemsFilter = _items;
    }
    notifyListeners();
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ProductAdapter());
    }
    final box = await Hive.openBox<Product>('products');
    // final ob = Product(
    //   name: "Nintendo Gameqube",
    //   description: "Приставка Nintendo Gameqube",
    //   imgUrl: 'assets/imgs/Nintendo Gameqube.jpg',
    //   price: 6540,
    //   id: 'q3',
    // );
    // box.add(ob);
    // box.clear();
    _readFromHive(box);
    box.listenable().addListener(() {
      _readFromHive(box);
    });
  }
}
