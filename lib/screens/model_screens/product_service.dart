import 'dart:convert';
import 'package:http/http.dart' as http;

class Product {
  final String product_name;
  final String price;
  final String img;
  final String supermarket;
  int quantity;
  bool isFavorite;

  Product({
    required this.product_name,
    required this.price,
    required this.img,
    required this.supermarket,
    this.quantity = 1,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      product_name: json['product_name'],
      price: json['price'],
      img: json['img'],
      supermarket: json['supermarket'],
    );
  }

  // Define the toJson method to convert a Product object to a Map
  Map<String, dynamic> toJson() {
    return {
      'product_name': product_name,
      'price': price,
      'img': img,
      'supermarket': supermarket,
    };
  }
}

class ProductService {
  Future<List<Product>> getProducts(String query) async {
    final response = await http.get(
      Uri.parse('https://igrosa-api.p.rapidapi.com/balmoral/$query'),
      headers: {
        'X-RapidAPI-Key': 'da74a0c4c9msh3767fd136826700p18f9dajsnb08dae65c8c2',
        'X-RapidAPI-Host': 'igrosa-api.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<Product> list = [];

      for (var entry in data) {
        list.add(Product.fromJson(entry));
      }
      return list;
    } else {
      throw Exception('HTTP Request Failed: ${response.statusCode}');
    }
  }
}
