import 'dart:convert';
import 'package:http/http.dart' as http;

class Product1 {
  final String product_name;
  final String price;
  final String img;
  final String supermarket;
  int quantity;

  Product1({
    required this.product_name,
    required this.price,
    required this.img,
    required this.supermarket,
    this.quantity = 1,
  });

  factory Product1.fromJson(Map<String, dynamic> json) {
    return Product1(
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
  Future<List<Product1>> getProducts(String category) async {
    // Create a map of category names to API endpoints
    Map<String, String> categoryEndpoints = {
      'drinks': 'drinks',
      'bread': 'bread',
      'meat': 'meat',
      'vegetables': 'vegetables',
      'snacks': 'snacks',
    };

    // Check if the provided category exists in the map
    if (!categoryEndpoints.containsKey(category)) {
      throw Exception('Invalid category');
    }

    // Build the API URL based on the category
    Uri uri = Uri.parse(
        'https://igrosa-api.p.rapidapi.com/balmoral/${categoryEndpoints[category]}');

    final response = await http.get(
      uri,
      headers: {
        'X-RapidAPI-Key': 'da74a0c4c9msh3767fd136826700p18f9dajsnb08dae65c8c2',
        'X-RapidAPI-Host': 'igrosa-api.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Product1> list = [];

      for (var entry in data) {
        list.add(Product1.fromJson(entry));
      }
      return list;
    } else {
      throw Exception('HTTP Request Failed: ${response.statusCode}');
    }
  }
}
