import 'package:flutter/material.dart';
import 'product_detail.dart';
import 'category_api.dart';

class ProductList extends StatefulWidget {
  final String category;

  const ProductList({Key? key, required this.category}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [];
  final productService = ProductService();
  Set<Product> cartItems = <Product>{};

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

  // Function to add a product to the cart
  void addToCart(Product product) {
    setState(() {
      cartItems.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products in ${widget.category}'),
        backgroundColor: Colors.green,
      ),
      body: products.isEmpty
          ? const Center(
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
                  trailing: Text(
                      'R${product.price.replaceAll('R', '')}'), // Update here
                  onTap: () {
                    // Navigate to the product detail screen on tap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetail(
                          product: product,
                          onAddToCart: addToCart, // Pass the addToCart function
                          cartItems: cartItems,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
