import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:text/object/product_object.dart';

import '../dep/deb.dart';
import '../ui/navigations/main_navigation.dart';

class ProductModel extends ChangeNotifier {
  void showDetail(BuildContext context, ProductData item) {
    Navigator.of(context)
        .pushNamed(MainNavigationRouteName.details, arguments: item.key);
  }

  var _items = <ProductData>[];
  List<ProductData> get items => _items.toList();
  List<ProductData> get itemsFilter => _itemsFilter.toList();
  var _itemsFilter = <ProductData>[];
  ProductModel() {
    _setup();
  }
  void _setup() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ProductDataAdapter());
    }
    final box = await Hive.openBox<ProductData>('products');
    // final ob = ProductData(
    //   name: "GD Emu",
    //   description: "Эмулятор привода для Dreamcast",
    //   imgUrl: 'assets/imgs/GD Emu.png',
    //   price: 7500,
    //   id: 'q1',
    // );
    // box.add(ob);
    //box.clear();
    _readFromHive(box);
    box.listenable().addListener(() {
      _readFromHive(box);
    });
  }

  void _readFromHive(Box<ProductData> box) {
    _items = box.values.toList();
    _itemsFilter = _items;
    notifyListeners();
  }

  void justFilter(String text) {
    _itemsFilter = [];
    _itemsFilter = text.isNotEmpty
        ? _items.where((element) {
            return element.name!.toLowerCase().contains(text.toLowerCase());
          }).toList()
        : _items;
    notifyListeners();
  }
}
