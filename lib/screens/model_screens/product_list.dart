import 'package:flutter/material.dart';
import 'product_service2.dart';
import 'product_detail.dart';

class ProductList extends StatefulWidget {
  final String category;

  ProductList({required this.category});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [];
  final productService = ProductService();

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final List<Product> productList =
          await productService.getProducts(widget.category);
      setState(() {
        products = productList;
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products in ${widget.category}'),
        backgroundColor: Colors.green,
      ),
      body: products.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: Image.network(product.img, width: 100, height: 100),
                  title: Text(product.product_name),
                  subtitle: Text(product.supermarket),
                  trailing: Text('R${product.price}'),
                  onTap: () {
                    // Navigate to the product detail screen on tap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetail(product: product),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
