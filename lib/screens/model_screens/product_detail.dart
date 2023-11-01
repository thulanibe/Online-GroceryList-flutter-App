import 'package:flutter/material.dart';
import 'product_service2.dart';
import 'cart_screen.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  final Function(Set<Product>) onAddToCart;
  final Set<Product> cartItems;

  ProductDetail(
      {required this.product,
      required this.onAddToCart,
      required this.cartItems});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int quantity = 1; // Quantity of the product, initialized to 1
  bool isFavorite = false; // Indicates if the product is in favorites

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

    widget.cartItems.add(productToAdd);

    widget.onAddToCart(widget.cartItems);

    // Display a snackbar confirming that the item was added to the cart
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Item added to cart',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  void navigateToCart() {
    Navigator.of(context).push(
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
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart), // Add a shopping cart icon
            onPressed: navigateToCart,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              widget.product.img,
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Product Name: ${widget.product.product_name}',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'Supermarket: ${widget.product.supermarket}',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'Price: R$price', // Display the modified price
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.favorite,
                      color: isFavorite ? Colors.red : Colors.grey),
                  onPressed: toggleFavorite,
                ),
                Text('Quantity: $quantity'),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: decrementQuantity,
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: incrementQuantity,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: addToCart,
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Set button color to green
              ),
              child: Text(
                'Add to Cart', // Updated button text
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            // Add more details or customizations here
          ],
        ),
      ),
    );
  }
}
