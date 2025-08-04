import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/providers/restaurants_provider.dart';
import 'package:restaurant_app/widgets/error_component.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class RestaurantFoodScreens extends StatefulWidget {
  const RestaurantFoodScreens({super.key});

  @override
  State<RestaurantFoodScreens> createState() => _RestaurantFoodScreensState();
}

class _RestaurantFoodScreensState extends State<RestaurantFoodScreens> {
  @override
  void initState() {
    final provider = Provider.of<RestaurantsProvider>(context, listen: false);
    provider.getRestaurantList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('build called');
    final provider = Provider.of<RestaurantsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Restaurant')),
      body: provider.isLoading
          ? getLoadingUI()
          : provider.error.isNotEmpty
          ? getErrorUI(provider.error)
          : getBodyUI(provider.baseResponseData.restaurants),
    );
  }

  Widget getLoadingUI() {
    return const Center(child: CircularProgressIndicator());
  }

  getBodyUI(List<Restaurant> restaurants) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) =>
          RestaurantItem(restaurant: restaurants[index]),
    );
  }
}
