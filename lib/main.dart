import 'package:flutter/material.dart';
import 'package:text/dep/deb.dart';
import 'package:text/ui/widgets/app/my_app_widget.dart';

void main() async {
  await Dep().init;
  runApp(const MyAppWidget());
}
