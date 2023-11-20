import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/material.dart';

@immutable
class Product extends Model {
  final String id;
  final String product_name;
  final String price;
  final int quantity;
  final String img;
  final bool isFavorite;

  const Product({
    required this.id,
    required this.product_name,
    required this.price,
    required this.quantity,
    required this.img,
    required this.isFavorite,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.product_name == product_name &&
        other.price == price &&
        other.quantity == quantity &&
        other.img == img &&
        other.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        product_name.hashCode ^
        price.hashCode ^
        quantity.hashCode ^
        img.hashCode ^
        isFavorite.hashCode;
  }

  @override
  String toString() {
    return 'Product{id: $id, product_name: $product_name, price: $price, quantity: $quantity, img: $img, isFavorite: $isFavorite}';
  }

  @override
  Type get modelType => throw UnimplementedError();

  @override
  String get typeName => throw UnimplementedError();

  @override
  Product fromJson(Map<String, dynamic> jsonData) {
    // Implement the deserialization logic
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() {
    // Implement the serialization logic
    throw UnimplementedError();
  }
}
