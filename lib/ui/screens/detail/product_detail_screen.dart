import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/theme/theme_app.dart';
import 'product_detail_model.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductDetailModel? _model;
  @override
  void didChangeDependencies() {
    if (_model == null) {
      final productKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = ProductDetailModel(productKey: productKey);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ProductDetailModel? model = _model;
    if (model != null) {
      return ChangeNotifierProvider(
        create: (context) => model,
        child: const ProductDetail(),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: const [
              _StackImgAndContent(),
              SizedBox(height: 12.0),
              _DishDetailedDescription(),
              // _MarcetWidget(),
              // SizedBox(height: 12.0),
              // _DishDetailedButtonBar(),
            ],
          ),
        ),
      ),
    );
  }
}

// class _MarcetWidget extends StatelessWidget {
//   const _MarcetWidget({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: _decoration(colors: Colors.black),
//       height: 3.5,
//       width: 30,
//     );
//   }
// }

class _StackImgAndContent extends StatelessWidget {
  const _StackImgAndContent({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        _ProductDetailedContainer(),
        _DishDetailedImg(),
        _DishDetailedButtonBack(),
      ],
    );
  }
}

class _DishDetailedImg extends StatelessWidget {
  const _DishDetailedImg({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<ProductDetailModel>();
    final imgUrl = model.product?.imgUrl;
    // print(imgUrl);
    return Align(
        child: imgUrl != null
            ? Image(
                height: 200,
                width: MediaQuery.of(context).size.width * 0.6,
                fit: BoxFit.contain,
                alignment: Alignment.bottomLeft,
                image: NetworkImage(
                  imgUrl,
                ),
              )
            : const SizedBox.shrink());
  }
}

class _ProductDetailedContainer extends StatelessWidget {
  const _ProductDetailedContainer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: _decoration(),
      margin: const EdgeInsets.only(top: 80),
      padding: const EdgeInsets.all(25.0),
      child: const _ProductDetailedContainerText(),
    );
  }
}

class _ProductDetailedContainerText extends StatelessWidget {
  const _ProductDetailedContainerText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<ProductDetailModel>();
    final title = model.product?.name ?? '## название отсутствует ##';
    final price = model.product?.price ?? 00;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const _ButtBookmark(),
        const SizedBox(height: 80),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child:
                    Text(title, style: _style(size: 22, fW: FontWeight.w500))),
            Container(
              decoration: _decoration(colors: Theme.of(context).primaryColor),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  '$price Р.',
                  style: _style(
                    size: 18,
                    fW: FontWeight.normal,
                    colors: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ButtBookmark extends StatelessWidget {
  const _ButtBookmark({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var isFav =
        context.watch<ProductDetailModel>().product?.isFavorite ?? false;
    var model = context.watch<ProductDetailModel>();
    return GestureDetector(
      onTap: () {
        model.toggFavorit();
      },
      child: Align(
        alignment: Alignment.topRight,
        child: Icon(Icons.favorite, color: isFav ? Colors.red : Colors.grey),
      ),
    );
  }
}

class _DishDetailedDescription extends StatelessWidget {
  const _DishDetailedDescription({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<ProductDetailModel>();
    final description = model.product?.description ?? '';
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Описание', style: _style(size: 22, fW: FontWeight.w500)),
              const SizedBox(height: 12.0),
              Text(description, style: _style()),
            ],
          ),
        ),
      ),
    );
  }
}

// class _DishDetailedButtonBar extends StatelessWidget {
//   const _DishDetailedButtonBar({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: _decoration(),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Row(
//                   children: [
//                     const Icon(
//                       Icons.add_circle_outline,
//                       size: 22,
//                       color: Colors.white,
//                     ),
//                     const SizedBox(width: 12.0),
//                     Text('1', style: _style()),
//                     const SizedBox(width: 12.0),
//                     const Icon(Icons.remove_circle_outline,
//                         size: 22, color: Colors.white)
//                   ],
//                 ),
//                 Row(children: [Text('total : 200\$ ', style: _style())])
//               ],
//             ),
//             const SizedBox(height: 12.0),
//             GestureDetector(
//               onTap: () {},
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 width: double.infinity,
//                 decoration: _decoration(colors: ThemeApp.kAccent),
//                 child: Center(
//                   child: Text('add to cart',
//                       style: _style(
//                         colors: Colors.white,
//                         fW: FontWeight.bold,
//                       )),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _DishDetailedButtonBack extends StatelessWidget {
  const _DishDetailedButtonBack({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<ProductDetailModel>();
    return GestureDetector(
      onTap: () => model.showMenu(context),
      child: Container(
        decoration: _decoration(),
        padding: const EdgeInsets.only(
          top: 20.0,
          bottom: 12.0,
          left: 12.0 + 10,
          right: 12.0,
        ),
        child: Icon(
          Icons.arrow_back_ios,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

_style({
  double size = 16,
  FontWeight fW = FontWeight.normal,
  Color colors = Colors.black,
}) {
  return TextStyle(
    color: colors,
    fontSize: size,
    fontWeight: fW,
    letterSpacing: 1.5,
    wordSpacing: 3.5,
  );
}

_decoration({Color colors = Colors.white}) {
  return BoxDecoration(
    color: colors,
    borderRadius: const BorderRadius.all(
      Radius.circular(12.0),
    ),
  );
}
