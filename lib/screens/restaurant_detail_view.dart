import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api_service.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/providers/restaurants_provider.dart';
import 'package:restaurant_app/screens/add_review_view.dart';
import 'package:restaurant_app/widgets/label_title_text.dart';
import 'package:restaurant_app/widgets/text_icon.dart';
import 'package:restaurant_app/widgets/title_text.dart';
import 'package:transparent_image/transparent_image.dart';

class RestaurantDetailScreens extends StatefulWidget {
  const RestaurantDetailScreens({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  State<RestaurantDetailScreens> createState() =>
      _RestaurantDetailScreensState();
}

class _RestaurantDetailScreensState extends State<RestaurantDetailScreens> {
  void _openAddReviewOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => AddReviewScreens(restoId: widget.restaurant.id),
    );
  }

  @override
  void initState() {
    final provider = Provider.of<RestaurantsProvider>(context, listen: false);
    provider.fetchRestaurantById(widget.restaurant.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('build called');
    final provider = Provider.of<RestaurantsProvider>(context);

    return getBodyUI(
      provider.baseResponse.restaurant,
      provider.error,
      provider.isLoading,
    );
  }

  Widget getLoadingUI() => const Center(child: CircularProgressIndicator());

  Widget getChipList(Restaurant restaurant, String error, bool isLoading) {
    debugPrint('chip: ${restaurant.name} - $isLoading');
    if (isLoading) return getLoadingUI();
    if (error.isNotEmpty) {
      return Text('Error: $error');
    }
    return Wrap(
      spacing: 8,
      children: [
        for (final category in restaurant.categories!)
          Chip(
            label: Text(category.name),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(16),
            ),
          ),
      ],
    );
  }

  Widget getCustomerReview(
    Restaurant restaurant,
    String error,
    bool isLoading,
  ) {
    // Consumer<RestaurantsProvider>(
    //   builder: (context, provider, child) {
    if (isLoading) return getLoadingUI();
    if (error.isNotEmpty) {
      return Text('Error: $error');
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: restaurant.customerReviews!.length,
      itemBuilder: (context, index) => ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(restaurant.customerReviews![index].name),
        subtitle: Text(restaurant.customerReviews![index].review),
        trailing: Text(restaurant.customerReviews![index].date ?? ''),
      ),
    );
    //   },
    // );
  }

  Widget getFoods(Restaurant restaurant, String error, bool isLoading) {
    if (isLoading) return getLoadingUI();
    if (error.isNotEmpty) {
      return Text('Error: $error');
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: restaurant.menus!.foods.length,
      itemBuilder: (context, index) => Text(
        restaurant.menus!.foods[index].name,
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }

  Widget getDrinks(Restaurant restaurant, bool isLoading) {
    if (isLoading) return SizedBox();
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: restaurant.menus!.drinks.length,
      itemBuilder: (context, index) => Text(
        restaurant.menus!.drinks[index].name,
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }

  Widget getBodyUI(Restaurant restaurant, String error, bool isLoading) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.restaurant.name)),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // RestaurantDetailScreens(restaurant: widget.restaurant),
                Hero(
                  tag: widget.restaurant.id,
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image:
                          '${ApiService.imageSmallBaseUrl}${widget.restaurant.pictureId}',
                      width: double.infinity,
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    TextIcon(
                      text: widget.restaurant.rating.toString(),
                      icon: Icons.star,
                    ),
                    const SizedBox(width: 20),
                    TextIcon(
                      text: widget.restaurant.city,
                      icon: Icons.location_on,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TitleText(text: widget.restaurant.name),
                const SizedBox(height: 4),
                getChipList(restaurant, error, isLoading),
                const SizedBox(height: 8),
                Text(
                  widget.restaurant.description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                LabelTitleText(text: 'Menus'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Foods',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          getFoods(restaurant, error, isLoading),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Drinks',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          getDrinks(restaurant, isLoading),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (restaurant.customerReviews != null &&
                    restaurant.customerReviews!.isNotEmpty)
                  LabelTitleText(text: 'Review'),
                if (restaurant.customerReviews != null &&
                    restaurant.customerReviews!.isNotEmpty)
                  getCustomerReview(restaurant, error, isLoading),
              ],
            ),
          ),

          Positioned(
            left: 100,
            right: 100,
            bottom: 20,
            child: ElevatedButton(
              onPressed: _openAddReviewOverlay,
              child: Text('Add Review'),
            ),
          ),
        ],
      ),
    );
  }
}
