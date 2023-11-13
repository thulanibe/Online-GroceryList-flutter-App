import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

Widget buildCarouselSlider(List<String> images) {
  return CarouselSlider(
    items: images.map((image) {
      return Builder(
        builder: (BuildContext context) {
          return _buildRoundedCardWithImage("Discounts", image);
        },
      );
    }).toList(),
    options: CarouselOptions(
      height: 200,
      autoPlay: true,
      enlargeCenterPage: true,
      viewportFraction: 0.8,
    ),
  );
}

Widget _buildRoundedCardWithImage(String title, String image) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      children: [
        Image.asset(
          image,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ],
    ),
  );
}
