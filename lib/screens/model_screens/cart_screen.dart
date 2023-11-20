import 'package:flutter/material.dart';
import 'grocery_api.dart';

class CartScreen extends StatefulWidget {
  final Set<Product> cartItems;

  CartScreen({required Key key, required this.cartItems}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalCost = 0.0;

  @override
  void initState() {
    super.initState();
    _updateTotalCost();
  }

  @override
  void didUpdateWidget(covariant CartScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateTotalCost();
  }

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
    final favoriteItems =
        widget.cartItems.where((item) => item.isFavorite).toList();
    final nonFavoriteItems =
        widget.cartItems.where((item) => !item.isFavorite).toList();

    favoriteItems.sort((a, b) => -1);
    nonFavoriteItems.sort((a, b) => 1);

    final sortedCartItems = [...favoriteItems, ...nonFavoriteItems];

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
                      Text('Price: R${item.price.replaceAll('R', '')}'),
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              color: Colors.green,
              child: ElevatedButton(
                onPressed: () {
                  _showSavedMessage();
                },
                child: Text(
                  'Save Items',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
              ),
            ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
