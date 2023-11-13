import 'package:flutter/material.dart';
import 'package:smartlist/screens/model_screens/home.dart';
import 'recipe_home.dart';
import 'grocery_page.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/images/deals.jpg',
      'assets/images/card2.png',
      'assets/images/bev.jpg',
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildRoundedCardWithImage("Discounts", images),
              _buildRoundedCardWithNavigation(
                context,
                "Category",
                'assets/images/Category.png',
                const Category(),
              ),
              _buildRoundedCardWithNavigation(
                context,
                "List",
                'assets/images/CreateList.png',
                const GroceryHome(),
              ),
              _buildRoundedCardWithNavigation(
                context,
                "Recipe",
                'assets/images/Recipe 1.jpg',
                const RecipePage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedCardWithImage(String title, List<String> images) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: CarouselSlider(
        items: images.map((image) {
          return Builder(
            builder: (BuildContext context) {
              return _buildRoundedCardWithSingleImage(image);
            },
          );
        }).toList(),
        options: CarouselOptions(
          height: 150, // Set the same height as other cards
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.8,
        ),
      ),
    );
  }

  Widget _buildRoundedCardWithSingleImage(String image) {
    return Image.asset(
      image,
      fit: BoxFit.cover,
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
