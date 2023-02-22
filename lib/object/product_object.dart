import 'package:hive/hive.dart';

part 'product_object.g.dart';

@HiveType(typeId: 0)
class ProductData extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? description;
  @HiveField(2)
  String? imgUrl;
  @HiveField(3)
  double? price;
  @HiveField(4)
  String? id;
  @HiveField(5)
  bool? isFavorite;
  ProductData({
    this.isFavorite = false,
    this.name,
    this.description,
    this.imgUrl,
    this.price,
    this.id,
  });

  ProductData.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    imgUrl = json['imgUrl'];
    isFavorite = json['isFavorite'];
    name = json['name'];
    price = (json['price']).toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['id'] = id;
    data['imgUrl'] = imgUrl;
    data['isFavorite'] = isFavorite;
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}

class Products {
  List<ProductData>? product;
  Products({this.product});
  Products.fromJson(Map<String, dynamic> json) {
    if (json['product'] != null) {
      product = <ProductData>[];
      json['product'].forEach((v) {
        product!.add(ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
