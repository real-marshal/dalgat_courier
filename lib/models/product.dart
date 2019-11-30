import 'package:dalgat_courier/services/db_service.dart';

class Product implements DBModel {
  String get collectionName => 'products';

  final String id;
  final String title;
  final String image;
  final int price;

  Product({this.id, this.title, this.image, this.price});

  @override
  Product fromMap(Map<String, dynamic> map) {
    return Product(
        id: map['id'],
        title: map['title'],
        image: map['image'],
        price: map['price'] ?? 0);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
    };
  }
}
