import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:text/firebase_options.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;

class Dep {
  Future<void> get init => _constructor();
  Future<void> _constructor() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      defaultTargetPlatform.name == 'windows'
          ? print('goood')
          : print(defaultTargetPlatform.name);
    }
    await Hive.initFlutter();
  }
}
