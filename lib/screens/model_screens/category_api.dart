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
}

class ProductService {
  static const String rapidApiKey =
      'ee1e28a5ccmshee57b4f1118087bp1047e5jsne2d7b0991043';
  static const String rapidApiHost = 'igrosa-api.p.rapidapi.com';

  Future<List<Product>> getProducts(String category) async {
    final categoryEndpoints = {
      'drinks': 'drinks',
      'bread': 'bread',
      'meat': 'meat',
      'vegetables': 'vegetables',
      'snacks': 'snacks',
      // Add more categories and endpoints as needed
    };

    if (!categoryEndpoints.containsKey(category)) {
      throw Exception('Invalid category');
    }

    final uri = Uri.https(
      rapidApiHost,
      'balmoral/${categoryEndpoints[category]}',
    );

    final response = await http.get(
      uri,
      headers: {
        'X-RapidAPI-Key': rapidApiKey,
        'X-RapidAPI-Host': rapidApiHost,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Product> list =
          data.map((entry) => Product.fromJson(entry)).toList();
      return list;
    } else {
      throw Exception('HTTP Request Failed: ${response.statusCode}');
    }
  }
}
