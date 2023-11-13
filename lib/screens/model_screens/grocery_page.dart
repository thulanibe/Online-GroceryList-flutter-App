import 'package:flutter/material.dart';
import 'grocery_api.dart';
import 'cart_screen.dart';

class GroceryHome extends StatefulWidget {
  const GroceryHome({super.key});

  @override
  _GroceryHomeState createState() => _GroceryHomeState();
}

class _GroceryHomeState extends State<GroceryHome> {
  late Future<List<Product>?> futureProducts;
  Set<Product> cartItems = <Product>{};
  Set<Product> favoriteItems = <Product>{};
  String searchText = '';
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts('drinks');
  }

  Future<List<Product>?> fetchProducts(String category) async {
    try {
      final productService = ProductService();
      final productList = await productService.getProducts(category);
      return productList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void addToCart(Product product) {
    setState(() {
      cartItems.add(product);
    });
    showItemAddedSnackBar();
  }

  void toggleFavorite(Product product) {
    setState(() {
      if (favoriteItems.contains(product)) {
        favoriteItems.remove(product);
      } else {
        favoriteItems.add(product);
      }
    });
  }

  void openCartScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return CartScreen(cartItems: cartItems);
        },
      ),
    );
  }

  void showItemAddedSnackBar() {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      const SnackBar(
        content: Text('Item added to the cart'),
      ),
    );
  }

  List<Product> filterProducts(List<Product> products, String searchText) {
    if (searchText.isEmpty) {
      return products;
    }

    return products
        .where((product) => product.product_name
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: isSearching ? buildSearchBar() : const Text('Create List'),
        actions: [
          if (isSearching)
            IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: endSearch,
            ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              openCartScreen(context);
            },
          ),
        ],
        bottom: isSearching
            ? null
            : PreferredSize(
                preferredSize: const Size.fromHeight(56.0),
                child: buildSearchBar(),
              ),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Product>?>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products available.'));
          } else {
            final products = snapshot.data!;
            final filteredProducts = filterProducts(products, searchText);

            return ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];

                // Remove one "R" from the price string
                final price = product.price.replaceFirst('R', '');

                return Card(
                  child: ListTile(
                    title: Text(
                      product.product_name, // No fontWeight applied
                    ),
                    subtitle: Text(
                      'R$price', // Updated here
                      style: TextStyle(color: Colors.green),
                    ),
                    leading: Image.network(product.img, width: 80, height: 80),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            favoriteItems.contains(product)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: favoriteItems.contains(product)
                                ? Colors.red
                                : null,
                          ),
                          onPressed: () {
                            toggleFavorite(product);
                          },
                        ),
                        ElevatedButton(
                          onPressed: () {
                            addToCart(product);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          child: const Text(
                            'Add to List',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget buildSearchBar() {
    return TextField(
        decoration: InputDecoration(
          hintText: 'Search Items',
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.cancel,
              color: Colors.green,
            ),
            onPressed: endSearch,
          ),
        ),
        onChanged: (value) {
          setState(() {
            searchText = value;
          });
        });
  }

  void startSearch() {
    setState(() {
      isSearching = true;
    });
  }

  void endSearch() {
    setState(() {
      isSearching = false;
      searchText = '';
    });
  }
}
