// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/object/product_model.dart';
import '../../screens/guiding_screen/guiding_model.dart';
import '../../theme/theme_app.dart';

class HomeHederWidget extends StatefulWidget {
  const HomeHederWidget({Key? key}) : super(key: key);
  @override
  State<HomeHederWidget> createState() => _HomeHederWidgetState();
}

class _HomeHederWidgetState extends State<HomeHederWidget> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: LimitedBox(
        maxWidth: 400,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Expanded(child: _SearchWidget()),
                SizedBox(width: 12.0),
                _FilterButtonWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const InputBorder styleSearch = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(style: BorderStyle.none),
    );
    const inputDecor = InputDecoration(
      contentPadding: EdgeInsets.zero,
      isDense: true,
      filled: true,
      fillColor: Color.fromARGB(255, 235, 235, 235),
      prefixIcon: Icon(Icons.search, color: Colors.grey),
      hintText: 'Search',
      enabledBorder: styleSearch,
      focusedBorder: styleSearch,
    );
    final control = context.watch<ProductModel>();
    return SizedBox(
      height: 33.0,
      child: TextField(
        decoration: inputDecor,
        onChanged: (text) {
          control.justFilter(text);
        },
      ),
    );
  }
}

class _FilterButtonWidget extends StatelessWidget {
  const _FilterButtonWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final styleBut = ElevatedButton.styleFrom(
      elevation: 0,
      shadowColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      side: const BorderSide(width: 2, color: ThemeApp.kAccent),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.12)),
    );
    final currentIndexTab = context.select(
      (GuidingScreenModel e) => e.currentIndexTab,
    );
    button(Function() colBak) {
      return ElevatedButton(
        style: styleBut,
        onPressed: colBak,
        child: const SizedBox(
          height: 33.0,
          child: Icon(Icons.tune, color: ThemeApp.kAccent),
        ),
      );
    }

    Widget getColBak(indexTab) {
      switch (indexTab) {
        case 0:
          return button(() => print('1'));
        case 1:
          return button(() => print('2'));
      }
      return const Text('data');
    }

    return getColBak(currentIndexTab);
  }
}
