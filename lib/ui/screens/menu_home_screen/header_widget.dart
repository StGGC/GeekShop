// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/object/product_model.dart';
import 'package:text/ui/screens/menu_home_screen/menu_home_model.dart';

class HomeHederWidget extends StatelessWidget {
  const HomeHederWidget({Key? key}) : super(key: key);
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
            FilterBox(),
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
      hintText: 'Поиск',
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
    final model = context.read<ProductModel>();
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
      onPressed: () => model.togIsOpenFilterBox(),
      child: SizedBox(
        height: 33.0,
        child: Icon(Icons.tune, color: Theme.of(context).primaryColor),
      ),
    );
  }
}

class FilterBox extends StatelessWidget {
  const FilterBox({super.key});
  @override
  Widget build(BuildContext context) {
    final model = context.watch<ProductModel>();

    Widget myRadioButton(FilterValue value, String title) {
      return Expanded(
        child: ListTile(
            title: Text(title),
            leading: Radio<FilterValue>(
              fillColor: MaterialStateColor.resolveWith((states) =>
                  model.isOpenFilterBox ? Colors.green : Colors.transparent),
              value: value,
              groupValue: model.filterValue,
              onChanged: (FilterValue? value) => model.togFilterValue(value),
            )),
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: model.isOpenFilterBox ? 100 : 0,
      child: Column(
        children: [
          myRadioButton(FilterValue.descendingOrder, 'По убыванию'),
          myRadioButton(FilterValue.ascending, 'По возрастанию'),
          Expanded(
            child: model.isOpenFilterBox
                ? RangeSlider(
                    values: model.currentRangeValues,
                    min: 0,
                    max: 14000,
                    divisions: 5,
                    labels: RangeLabels(
                      model.currentRangeValues.start.round().toString(),
                      model.currentRangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) => model.priceRange(values),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
