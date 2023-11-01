import 'package:flutter/material.dart';
import 'package:smartlist/screens/model_screens/home.dart';
import 'recipe_home.dart';
import 'grocery_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildRoundedCard("Product", null), // No image for the first card
              _buildRoundedCardWithNavigation(
                  context,
                  "Category",
                  'assets/images/Category.png',
                  const Category()), // Navigate to CategoryPage
              _buildRoundedCardWithNavigation(
                  context,
                  "List",
                  'assets/images/CreateList.png',
                  GroceryHome()), //Navigate to GroceryPage
              _buildRoundedCardWithNavigation(
                  context,
                  "Recipe",
                  'assets/images/Recipe 1.jpg',
                  RecipePage()), //Navigate to RecipePage
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedCard(String title, String? imagePath) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          if (imagePath != null) // Display image if imagePath is not null
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15.0),
                bottom: Radius.circular(15.0),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150,
              ),
            )
          else // Display an empty white container if imagePath is null
            Container(
              width: double.infinity,
              height: 150,
              color: Colors.white,
            ),
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(8.0),
              color: Colors.transparent,
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
    );
  }

  Widget _buildRoundedCardWithNavigation(BuildContext context, String title,
      String? imagePath, Widget destinationPage) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => destinationPage));
      },
      child: _buildRoundedCard(title, imagePath),
    );
  }
}

// class CategoryPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Category Page"),
//       ),
//       body: Center(
//         child: Text("This is the Category Page."),
//       ),
//     );
//   }
// }
