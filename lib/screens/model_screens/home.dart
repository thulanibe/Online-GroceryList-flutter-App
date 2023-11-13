import 'package:flutter/material.dart';
import 'product_list.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Category", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () async {
              final result = await showSearch(
                context: context,
                delegate: CategorySearch(),
              );

              if (result != null) {
                // Handle the selected item (result) here
                print("Selected item: $result");
              }
            },
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildRoundedCardWithNavigation(
                context,
                "Fruits & Vegetables",
                'assets/images/F&V.jpg',
                const ProductList(
                    category:
                        'vegetables'), // Navigate to ProductList for 'vegetables'
              ),
              _buildRoundedCardWithNavigation(
                context,
                "Meat",
                'assets/images/Meat.jpg',
                const ProductList(
                    category: 'meat'), // Navigate to ProductList for 'meat'
              ),
              _buildRoundedCardWithNavigation(
                context,
                "Beverages",
                'assets/images/Beverages.jpg',
                const ProductList(
                    category: 'drinks'), // Navigate to ProductList for 'drinks'
              ),
              _buildRoundedCardWithNavigation(
                context,
                "Bakery",
                'assets/images/Bakery.jpg',
                const ProductList(
                    category: 'bread'), // Navigate to ProductList for 'bread'
              ),
              _buildRoundedCardWithNavigation(
                context,
                "Snacks",
                'assets/images/snacks.jpg',
                const ProductList(
                    category: 'snacks'), // Navigate to ProductList for 'snacks'
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedCardWithNavigation(BuildContext context, String title,
      String imagePath, Widget destination) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15.0),
                      bottom: Radius.circular(15.0)),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 150,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black.withOpacity(0),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategorySearch extends SearchDelegate<String> {
  final List<String> _data = [
    "Fruits & Vegetables",
    "Meat",
    "Beverages",
    "Bakery",
    "Personal Care",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> searchResults = _filterData(query);

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        // Use the search result as the image name
        final imageName =
            searchResults[index].toLowerCase().replaceAll(' ', '');

        return _buildRoundedCardWithNavigation(
          context,
          searchResults[index],
          'assets/images/$imageName.jpg',
          ProductList(
              category: searchResults[index]
                  .toLowerCase()), // Navigate to ProductList for the selected category
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  List<String> _filterData(String query) {
    return _data
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Widget _buildRoundedCardWithNavigation(BuildContext context, String title,
      String imagePath, Widget destination) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15.0),
                      bottom: Radius.circular(15.0)),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 150,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black.withOpacity(0),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
