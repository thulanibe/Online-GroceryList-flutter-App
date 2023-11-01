import 'dart:async';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int currentAdIndex = 0;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  /// Start a timer to rotate ads at regular intervals.
  void startTimer() {
    const Duration rotationDuration = Duration(seconds: 5);
    Timer.periodic(rotationDuration, (Timer timer) {
      setState(() {
        currentAdIndex = (currentAdIndex + 1) % ads.length;
      });
    });
  }

  /// Build a slide for the ad with a given image path.
  Widget buildAdSlide(String adImagePath) {
    if (ads.isEmpty) {
      return Container(); // Or show a default image
    }

    return Container(
      margin: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          adImagePath,
          width: 200.0,
          height: 150.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// Build a card with an image, title, and index.
  Widget buildImageCard(String imagePath, String title, int index) {
    if (index == 1) {
      imagePath = 'assets/images/pic2.jpg';
    } else if (index == 2) {
      imagePath = 'assets/images/pic3.jpg';
    } else if (index == 3) {
      imagePath = 'assets/images/pic7.jpg';
    } else if (index == 4) {
      imagePath = 'assets/images/pic6.jpg';
    } else if (index == 5) {
      imagePath = 'assets/images/pic4.jpg';
    }

    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: GestureDetector(
        onTap: () {
          print('Image $title pressed!');
          // Add more actions or show a snackbar for user feedback.
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15.0)),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<String> ads = [
    'assets/images/Grocery-discount.jpg',
    'assets/images/Grocery-discount.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    double appBarHeight = MediaQuery.of(context).size.height * 0.2;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          height: appBarHeight,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/SmartList11.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 16.0,
                right: 16.0,
                child: PopupMenuButton<String>(
                  onSelected: (value) {
                    // Handle menu item selection
                    print('Selected: $value');
                  },
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'item1',
                        child: Text('Category'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'item2',
                        child: Text('Grocery History'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'item3',
                        child: Text('Logout'),
                      ),
                    ];
                  },
                  child: const Icon(
                    Icons.menu_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(),

            // ... (add more containers as needed)
          ],
        ),
      ),
    );
  }
}
