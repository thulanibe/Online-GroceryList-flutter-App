import 'package:flutter/material.dart';
import 'grocery_api.dart';

class CartScreen extends StatefulWidget {
  final Set<Product> cartItems;

  const CartScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalCost = 0.0;

  void _updateTotalCost() {
    double tempTotal = 0.0;
    widget.cartItems.forEach((item) {
      final numericPrice = double.tryParse(item.price.substring(1)) ?? 0.0;
      tempTotal += numericPrice * item.quantity;
    });

    setState(() {
      totalCost = tempTotal;
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
  Widget build(BuildContext context) {
    // Calculate the total cost as a double
    final totalCostString =
        'R${totalCost.toStringAsFixed(0)}'; // Format as "R50"

    // Separate favorite and non-favorite items
    final favoriteItems =
        widget.cartItems.where((item) => item.isFavorite).toList();
    final nonFavoriteItems =
        widget.cartItems.where((item) => !item.isFavorite).toList();

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
              children: [
                ...favoriteItems.map((item) => _buildCartItemTile(item)),
                ...nonFavoriteItems.map((item) => _buildCartItemTile(item)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total Cost: $totalCostString',
              style: const TextStyle(color: Colors.green, fontSize: 20),
            ),
          ),
          if (widget.cartItems.isNotEmpty)
            ElevatedButton(
              onPressed: () {
                _showSavedMessage();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: const Text(
                'Save Items',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildCartItemTile(Product item) {
    final price = 'R${(item.price.substring(1))}';
    return Card(
      child: ListTile(
        title: Text(
          item.product_name,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price: $price',
              style: const TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => _decreaseQuantity(item),
                ),
                Text('Quantity: ${item.quantity}'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _increaseQuantity(item),
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
      ),
    );
  }
}
