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
