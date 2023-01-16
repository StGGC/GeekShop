import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../object/product_object.dart';

class GuidingScreenModel extends ChangeNotifier {
  var _currentIndexTab = 0;
  int get currentIndexTab => _currentIndexTab;

  setCurrentIndexTab(int? index) {
    if (index != null) {
      _currentIndexTab = index;
      notifyListeners();
      if (index == 1) {
        if (!Hive.isAdapterRegistered(0)) {
          Hive.registerAdapter(ProductDataAdapter());
        }
      }
    }
  }
}
