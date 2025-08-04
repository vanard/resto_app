import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/screens/restaurant_detail_view.dart';
import 'package:restaurant_app/widgets/title_text.dart';
import 'package:transparent_image/transparent_image.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RestaurantDetailScreens(restaurant: restaurant),
          ),
        );
      },
      child: Container(
        margin: EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16),
              child: Hero(
                tag: restaurant.id,
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: '${Api.imageSmall_base_url}${restaurant.pictureId}',
                  fit: BoxFit.cover,
                  height: 180,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 8),
            TitleText(text: restaurant.name),
            // Text(
            //   restaurant.name,
            //   style: Theme.of(context).textTheme.titleLarge!.copyWith(
            //     color: Theme.of(context).colorScheme.tertiary,
            //   ),
            // ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  restaurant.city,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.star, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 4),
                Text(
                  restaurant.rating.toString(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
