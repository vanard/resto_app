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
    // final provider = Provider.of<RestaurantsProvider>(context, listen: false);
    // provider.dispose();
    // _searchTextController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('build called');
    final provider = Provider.of<RestaurantsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: provider.isSearching
            ? TextField(
                onSubmitted: _onSearchChanged,
                controller: provider.searchTextController,
                decoration: InputDecoration(
                  hintText: 'Search for restaurants...',
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                autofocus: true,
                onChanged: _onSearchChanged,
              )
            // : TitleText(text: 'Restaurant'),
            : Text('Restaurant'),
        actions: [
          IconButton(
            onPressed: () {
              provider.onToggleSearch();
              // setState(() {

              //   _searchTextController.text = '';
              //   _isSearching = !_isSearching;
              // });
            },
            icon: provider.isSearching ? Icon(Icons.close) : Icon(Icons.search),
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
    return Center(
      child: Text(
        error,
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }

  getBodyUI(List<Restaurant> restaurants) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) =>
          RestaurantItem(restaurant: restaurants[index]),
    );
  }
}
