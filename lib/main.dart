import 'package:flutter/material.dart';
import 'package:text/ui/screens_factory/widget_factory.dart';
import 'dep/deb.dart';

void main() async {
  await Dep().initFirebase();
  await Dep().initApi();
  runApp(ScreensFactory().initScreen());
}
