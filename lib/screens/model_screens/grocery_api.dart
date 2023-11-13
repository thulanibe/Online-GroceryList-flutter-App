// ignore_for_file: non_constant_identifier_names

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
  Future<List<Product>> getProducts(String itemName) async {
    Uri uri;

    if (itemName == 'balmoral') {
      uri = Uri.parse('https://igrosa-api.p.rapidapi.com/balmoral');
    } else if (itemName == 'drinks') {
      uri = Uri.parse('https://igrosa-api.p.rapidapi.com/balmoral/drinks');
    } else if (itemName == 'bread') {
      uri = Uri.parse('https://igrosa-api.p.rapidapi.com/balmoral/bread');
    } else if (itemName == 'vegetables') {
      uri = Uri.parse('https://igrosa-api.p.rapidapi.com/balmoral/vegetables');
    } else if (itemName == 'snacks') {
      uri = Uri.parse('https://igrosa-api.p.rapidapi.com/balmoral/snacks');
    } else if (itemName == 'meat') {
      uri = Uri.parse('https://igrosa-api.p.rapidapi.com/balmoral/meat');
    } else {
      throw Exception('Invalid item name');
    }

    final response = await http.get(
      uri,
      headers: {
        'X-RapidAPI-Key': 'ee1e28a5ccmshee57b4f1118087bp1047e5jsne2d7b0991043',
        'X-RapidAPI-Host': 'igrosa-api.p.rapidapi.com',
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
