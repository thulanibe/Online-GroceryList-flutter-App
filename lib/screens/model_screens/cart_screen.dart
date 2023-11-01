import 'package:flutter/material.dart';
import 'grocery_api.dart';

class CartScreen extends StatefulWidget {
  final Set<Product> cartItems;

  CartScreen({required this.cartItems});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalCost = 0.0;

  void _updateTotalCost() {
    totalCost = widget.cartItems.fold(0, (sum, item) {
      final numericPrice =
          double.tryParse(item.price.replaceAll('R', '').trim()) ?? 0.0;
      return sum + numericPrice * item.quantity;
    });
  }

  void _increaseQuantity(Product product) {
    setState(() {
      final cartItem = widget.cartItems.firstWhere(
        (item) => item.product_name == product.product_name,
      );
      cartItem.quantity++;
      _updateTotalCost();
    });
  }

  void _decreaseQuantity(Product product) {
    setState(() {
      final cartItem = widget.cartItems.firstWhere(
        (item) => item.product_name == product.product_name,
      );
      if (cartItem.quantity > 1) {
        cartItem.quantity--;
        _updateTotalCost();
      }
    });
  }

  void _removeItem(Product product) {
    setState(() {
      widget.cartItems
          .removeWhere((item) => item.product_name == product.product_name);
      _updateTotalCost();
    });
  }

  @override
  void initState() {
    super.initState();
    _updateTotalCost();
  }

  void _showSavedMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("List Saved"),
          content: Text("Your items have been saved."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK", style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.green, // Set AppBar background color to green
        iconTheme:
            IconThemeData(color: Colors.white), // Set icon color to white
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: widget.cartItems.map((item) {
                return ListTile(
                  title: Text(item.product_name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price: R${item.price}'),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () => _decreaseQuantity(item),
                          ),
                          Text('Quantity: ${item.quantity}'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => _increaseQuantity(item),
                          ),
                        ],
                      ),
                    ],
                  ),
                  leading: Image.network(item.img),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeItem(item),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total Cost: R${totalCost.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.grey), // Set text color to white
            ),
          ),
          if (widget.cartItems
              .isNotEmpty) // Conditionally display the "Save Items" button
            ElevatedButton(
              onPressed: () {
                _showSavedMessage(); // Show the saved message
              },
              child: Text(
                'Save Items',
                style: TextStyle(color: Colors.white),
              ), // Set button text color to white
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Set button background color to green
              ),
            ),
        ],
      ),
      backgroundColor:
          Colors.white, // Set the background color of the page to white
    );
  }
}
