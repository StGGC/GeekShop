import 'package:hive/hive.dart';
part 'product_object.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String description;
  @HiveField(2)
  String imgUrl;
  @HiveField(3)
  double price;
  @HiveField(4)
  String id;
  @HiveField(5)
  bool isFavorite;
  Product({
    this.isFavorite = false,
    required this.name,
    required this.description,
    required this.imgUrl,
    required this.price,
    required this.id,
  });
}
