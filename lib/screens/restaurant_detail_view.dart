import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api.dart';
import 'package:restaurant_app/models/base_response.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/providers/restaurants_provider.dart';
import 'package:restaurant_app/widgets/divider.component.dart';
// import 'package:restaurant_app/providers/restaurant_provider.dart';
import 'package:restaurant_app/widgets/label_title_text.dart';
import 'package:restaurant_app/widgets/title_text.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:transparent_image/transparent_image.dart';

class RestaurantDetailScreens extends StatefulWidget {
  const RestaurantDetailScreens({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  State<RestaurantDetailScreens> createState() =>
      _RestaurantDetailScreensState();
}

class _RestaurantDetailScreensState extends State<RestaurantDetailScreens> {
  @override
  void initState() {
    final provider = Provider.of<RestaurantsProvider>(context, listen: false);
    provider.getRestaurantById(widget.restaurant.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('build called');
    final provider = Provider.of<RestaurantsProvider>(context);
    // final restaurant = provider.baseResponse.restaurant;

    return
    //  provider.isLoading
    //     ? getLoadingUI()
    // : provider.error.isNotEmpty
    // ? getErrorUI(provider.error)
    // :
    getBodyUI(provider.baseResponse, provider.error, provider.isLoading);
  }

  // Widget getLoadingUI() {
  //   return Scaffold(
  //     appBar: AppBar(title: Text(widget.restaurant.name)),
  //     body: SingleChildScrollView(
  //       padding: EdgeInsets.symmetric(horizontal: 16),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Hero(
  //             tag: widget.restaurant.id,
  //             child: ClipRRect(
  //               borderRadius: BorderRadiusGeometry.circular(16),
  //               child: FadeInImage.memoryNetwork(
  //                 placeholder: kTransparentImage,
  //                 image:
  //                     '${Api.imageSmall_base_url}${widget.restaurant.pictureId}',
  //                 width: double.infinity,
  //                 height: 240,
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 16),
  //           TitleText(text: widget.restaurant.name),
  //           const SizedBox(height: 8),
  //           Row(
  //             children: [
  //               Icon(
  //                 Icons.location_on,
  //                 color: Theme.of(context).colorScheme.primary,
  //               ),
  //               const SizedBox(width: 4),
  //               Text(
  //                 widget.restaurant.city,
  //                 style: Theme.of(context).textTheme.bodySmall!.copyWith(
  //                   color: Theme.of(context).colorScheme.tertiary,
  //                 ),
  //               ),
  //               Spacer(),
  //               Icon(Icons.star, color: Theme.of(context).colorScheme.primary),
  //               const SizedBox(width: 4),
  //               Text(
  //                 widget.restaurant.rating.toString(),
  //                 style: Theme.of(context).textTheme.bodySmall!.copyWith(
  //                   color: Theme.of(context).colorScheme.tertiary,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget getChipList(Restaurant restaurant, bool isLoading) {
    return Skeletonizer(
      enabled: isLoading,
      child: !isLoading && restaurant.categories != null
          ? Wrap(
              spacing: 16,
              children: [
                for (final category in restaurant.categories!)
                  Chip(label: Text(category.name)),
              ],
            )
          : isLoading
          ? const Chip(label: Text(''))
          : const Text('No categories found'),
    );
  }

  Widget getCustomerReview(Restaurant restaurant, bool isLoading) {
    return Skeletonizer(
      enabled: isLoading,
      child: !isLoading && restaurant.customerReviews != null
          ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: restaurant.customerReviews!.length,
              itemBuilder: (context, index) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(restaurant.customerReviews![index].name),
                subtitle: Text(restaurant.customerReviews![index].review),
                trailing: Text(restaurant.customerReviews![index].date),
              ),
            )
          : isLoading
          ? const ListTile(
              title: Text(''),
              subtitle: Text(''),
              trailing: Text(''),
            )
          : const Text('No customer reviews found'),
    );
  }

  Widget getBodyUI(BaseResponse response, String error, bool isLoading) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.restaurant.name)),
      body: SingleChildScrollView(
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
                      '${Api.imageSmall_base_url}${widget.restaurant.pictureId}',
                  width: double.infinity,
                  height: 240,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TitleText(text: widget.restaurant.name),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  widget.restaurant.city,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                Spacer(),
                Icon(Icons.star, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 4),
                Text(
                  widget.restaurant.rating.toString(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            DividerComponent(),
            const SizedBox(height: 8),
            LabelTitleText(text: 'Category'),
            // error.isNotEmpty
            //     ? Text(error)
            //     :
            getChipList(response.restaurant, isLoading),
            const SizedBox(height: 8),
            DividerComponent(),
            const SizedBox(height: 8),
            LabelTitleText(text: 'Description'),
            const SizedBox(height: 8),
            Text(widget.restaurant.description, textAlign: TextAlign.justify),
            const SizedBox(height: 8),
            DividerComponent(),
            const SizedBox(height: 8),
            if (response.restaurant.customerReviews != null &&
                response.restaurant.customerReviews!.isNotEmpty)
              LabelTitleText(text: 'Review'),
            // Text('Customer Review Here'),
            if (response.restaurant.customerReviews != null &&
                response.restaurant.customerReviews!.isNotEmpty)
              getCustomerReview(response.restaurant, isLoading),
          ],
        ),
      ),
    );
  }
}
