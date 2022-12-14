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
      hintStyle: TextStyle(color: Colors.black87),
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
      side: BorderSide(width: 2, color: Theme.of(context).primaryColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.12)),
    );

    return ElevatedButton(
      style: styleBut,
      onPressed: () {},
      child: SizedBox(
        height: 33.0,
        child: Icon(Icons.tune, color: Theme.of(context).primaryColor),
      ),
    );
  }
}
