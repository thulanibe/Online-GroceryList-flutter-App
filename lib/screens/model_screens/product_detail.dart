import 'package:flutter/material.dart';
import 'category_api.dart';
import 'cart_screen2.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  final Function(Product) onAddToCart;
  final Set<Product> cartItems;

  const ProductDetail({
    super.key,
    required this.product,
    required this.onAddToCart,
    required this.cartItems,
  });

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int quantity = 1; // Quantity of the product, initialized to 1
  bool isFavorite = false;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void addToCart() {
    final productToAdd = Product(
      product_name: widget.product.product_name,
      supermarket: widget.product.supermarket,
      price: widget.product.price,
      img: widget.product.img,
    );

    widget.onAddToCart(productToAdd);

    // Display a snackbar confirming that the item was added to the cart
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Item added to cart',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  void navigateToCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return CartScreen(cartItems: widget.cartItems);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Remove one "R" from the price string
    final price = widget.product.price.replaceFirst('R', '');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.product_name,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart), // Add a shopping cart icon
            onPressed: () => navigateToCart(context), // Navigate to CartScreen2
          ),
        ],
      ),
      // ... rest of your widget build code
    );
  }
}
