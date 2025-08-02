import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:restaurant_app/screens/restaurant_food_screens.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedNavigationIndex = 0;
  late final List<Widget> pages;

  @override
  void initState() {
    pages = [navBarPage(0), navBarPage(1), navBarPage(2)];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedNavigationIndex,
        backgroundColor: Colors.white,
        elevation: 0,
        iconSize: 28,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ).copyWith(color: Theme.of(context).colorScheme.primary),
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
          BottomNavigationBarItem(icon: Icon(Iconsax.home5), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.heart5),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.profile_circle5),
            label: 'Profile',
          ),
        ],
      ),
      body: pages[selectedNavigationIndex],
    );
  }

  navBarPage(int index) {
    switch (index) {
      case 0:
        return const RestaurantFoodScreens();
      case 1:
        return const Center(child: Text('Favorites Page'));
      case 2:
        return const Center(child: Text('Profile Page'));
      default:
        return const Center(child: Text('Page Not Found'));
    }
  }
}
