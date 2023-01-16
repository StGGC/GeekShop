import '../../../object/product_object.dart';

class Cart {
  String id;
  int count;
  ProductData product;

  Cart({
    required this.id,
    required this.product,
    required this.count,
  });
}
