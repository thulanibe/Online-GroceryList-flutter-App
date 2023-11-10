import 'package:flutter/material.dart';
import 'category_api.dart';

class CartScreen extends StatefulWidget {
  final Set<Product> cartItems;

  const CartScreen({super.key, required this.cartItems});

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

  void _changeQuantity(Product product, int change) {
    setState(() {
      final cartItem = widget.cartItems.firstWhere(
        (item) => item.product_name == product.product_name,
      );
      cartItem.quantity += change;
      if (cartItem.quantity < 1) {
        cartItem.quantity = 1;
      }
      _updateTotalCost();
    });
  }

  void _removeItem(Product product) {
    setState(() {
      widget.cartItems
          .removeWhere((item) => item.product_name == product.product_name);
      _updateTotalCost();
    });
  }

  void _showSavedMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("List Saved"),
          content: const Text("Your items have been saved."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK", style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _updateTotalCost();
  }

  @override
  Widget build(BuildContext context) {
    // Sort the cartItems list by product name
    final sortedCartItems = widget.cartItems.toList()
      ..sort((a, b) => a.product_name.compareTo(b.product_name));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: sortedCartItems.map((item) {
                return ListTile(
                  title: Text(item.product_name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price: R${item.price}'),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => _changeQuantity(item, -1),
                          ),
                          Text('Quantity: ${item.quantity}'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => _changeQuantity(item, 1),
                          ),
                        ],
                      ),
                    ],
                  ),
                  leading: Image.network(item.img),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
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
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          if (widget.cartItems.isNotEmpty)
            ElevatedButton(
              onPressed: () {
                _showSavedMessage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'Save Items',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}