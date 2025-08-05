import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/providers/restaurants_provider.dart';
import 'package:restaurant_app/utils/debouncer.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class RestaurantFoodScreens extends StatefulWidget {
  const RestaurantFoodScreens({super.key});

  @override
  State<RestaurantFoodScreens> createState() => _RestaurantFoodScreensState();
}

class _RestaurantFoodScreensState extends State<RestaurantFoodScreens> {
  var _isSearching = false;
  final _searchTextController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 500);

  void _onSearchChanged(String query) {
    _debouncer.run(() {
      final provider = Provider.of<RestaurantsProvider>(context, listen: false);
      provider.searchRestaurants(query);
      debugPrint("Performing search for: $query");
    });
  }

  @override
  void initState() {
    final provider = Provider.of<RestaurantsProvider>(context, listen: false);
    provider.fetchRestaurantList();
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('build called');
    final provider = Provider.of<RestaurantsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                onSubmitted: _onSearchChanged,
                controller: _searchTextController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
                autofocus: true,
                onChanged: _onSearchChanged,
              )
            : Text('Restaurant'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _searchTextController.text = '';
                _isSearching = !_isSearching;
              });
            },
            icon: _isSearching ? Icon(Icons.close) : Icon(Icons.search),
          ),
        ],
      ),
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

  Widget getErrorUI(String error) {
    return Center(child: Text(error));
  }

  getBodyUI(List<Restaurant> restaurants) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) =>
          RestaurantItem(restaurant: restaurants[index]),
    );
  }
}
