import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:text/ui/navigations/main_navigation.dart';
import 'package:text/ui/widgets/app/my_app_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase  init ');
  } catch (e) {
    print('Firebase no init ');
  }
  await Hive.initFlutter();
  runApp(const MyAppWidget());
}
