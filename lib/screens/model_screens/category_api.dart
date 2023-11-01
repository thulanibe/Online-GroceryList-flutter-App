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
  static const String rapidApiKey =
      'da74a0c4c9msh3767fd136826700p18f9dajsnb08dae65c8c2';
  static const String rapidApiHost = 'igrosa-api.p.rapidapi.com';

  Future<List<Product>> getProducts(String category) async {
    // Define the available categories and their corresponding endpoints
    Map<String, String> categoryEndpoints = {
      'drinks': 'drinks',
      'bread': 'bread',
      'meat': 'meat',
      'vegetables': 'vegetables',
      'snacks': 'snacks', // Add the 'snacks' category
      // Add more categories and endpoints as needed
    };

    // Check if the provided category exists in the map
    if (!categoryEndpoints.containsKey(category)) {
      throw Exception('Invalid category');
    }

    // Build the API URL based on the category
    Uri uri = Uri.parse(
        'https://$rapidApiHost/balmoral/${categoryEndpoints[category]}');

    final response = await http.get(
      uri,
      headers: {
        'X-RapidAPI-Key': rapidApiKey,
        'X-RapidAPI-Host': rapidApiHost,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
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
