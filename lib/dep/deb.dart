import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart';
import 'package:text/firebase_options.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:text/object/product_object.dart';

class Dep {
  Future<void> initFirebase() => _constructor();
  Future<void> initApi() => makeGetRequest();
  Future<void> _constructor() async {
    if (defaultTargetPlatform.name != 'windows') {
      try {
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      } catch (e) {
        print('not init firebase');
      }
    }

    await Hive.initFlutter();
  }

  Future<void> makeGetRequest() async {
    await clearHive();
    var urlPrefix = 'https://prt2b-6f7d3-default-rtdb.firebaseio.com';
    final url = Uri.parse('$urlPrefix/products.json');
    Response response = await get(url);
    if (response.statusCode == 200) {
      var products = Products.fromJson(jsonDecode(response.body));
      for (var element in products.product!) {
        await initProduct(element);
      }
    }
  }

  Future<void> clearHive() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ProductDataAdapter());
    }
    final box = await Hive.openBox<ProductData>('products');
    box.clear();
  }

  Future<void> initProduct(ProductData item) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ProductDataAdapter());
    }
    final box = await Hive.openBox<ProductData>('products');
    box.add(item);
  }
}
