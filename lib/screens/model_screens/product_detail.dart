import 'package:flutter/material.dart';
import 'category_api.dart';
import 'cart_screen2.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  final Function(Product) onAddToCart;
  final Set<Product> cartItems;

  const ProductDetail({
    Key? key,
    required this.product,
    required this.onAddToCart,
    required this.cartItems,
  }) : super(key: key);

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
      isFavorite: isFavorite, // Include isFavorite status
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

  void openCartScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return CartScreen(cartItems: widget.cartItems, key: GlobalKey());
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
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              openCartScreen(context);
            }, // Call the openCartScreen method
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the product details
            Image.network(widget.product.img, width: 100, height: 100),
            Text('Product: ${widget.product.product_name}'),
            Text('Supermarket: ${widget.product.supermarket}'),
            Text('Price: R$price'), // Updated here
            Text('Quantity: $quantity'),
            // Display a favorite button with a heart icon
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: toggleFavorite,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    decrementQuantity();
                  },
                ),
                Text('$quantity'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    incrementQuantity();
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addToCart,
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: Text(
                'Add to List',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
