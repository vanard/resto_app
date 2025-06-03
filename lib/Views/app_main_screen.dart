import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:restaurant_app/Utils/colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedNavigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedNavigationIndex,
        backgroundColor: Colors.white,
        elevation: 0,
        iconSize: 28,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: kPrimaryColor,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
        onTap: (int index) {
          setState(() {
            // Update the selected index when a navigation item is tapped
            selectedNavigationIndex = index;
          });
        },
        items: [
        BottomNavigationBarItem(
          icon: Icon(Iconsax.home5),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.heart5),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.profile_circle5),
          label: 'Profile',
        ),
      ]),
    );
  }
}