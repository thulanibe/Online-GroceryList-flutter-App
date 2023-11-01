import 'package:flutter/material.dart';
import 'package:smartlist/widgets/nav_bar.dart';
import 'package:smartlist/widgets/palatte.dart';

import 'model_screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    // getUserAttributes();
  }

  int currentIndex = 0;
  final screens = [
    const HomeScreen(),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0), // Set the preferred height
        child: AppBar(
          elevation: mainElevation,
          backgroundColor: Colors.white,
          centerTitle: true, // Center the title
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: const CircleAvatar(
              radius: 20.0,
              backgroundColor: backgroundColor,
              child: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
          ),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Grocery_bag.png',
                width: 80, // Adjust the width as needed
                height: 80, // Adjust the height as needed
              ),
              const SizedBox(
                  height: 4), // Add the desired space between image and title
              const Text(
                'Smart List',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          actions: const [
            // Add any other actions you may need
          ],
        ),
      ),
      drawer: const NavBar(),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
    );
  }
}
