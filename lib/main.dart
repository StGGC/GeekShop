import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/dep/deb.dart';
import 'package:text/ui/theme/theme_app.dart';
import 'package:text/ui/widgets/app/my_app_widget.dart';

void main() async {
  await Dep().init();
  runApp(ChangeNotifierProvider<MyThemeNotifier>(
    create: (_) => MyThemeNotifier(),
    child: const MyAppWidget(),
  ));
}
