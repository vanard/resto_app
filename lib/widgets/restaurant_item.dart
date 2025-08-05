import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api_service.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/screens/restaurant_detail_view.dart';
import 'package:restaurant_app/widgets/text_icon.dart';
import 'package:restaurant_app/widgets/title_text.dart';
import 'package:transparent_image/transparent_image.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    debugPrint('build item: ${restaurant.name}');

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
                  image:
                      '${ApiService.imageSmallBaseUrl}${restaurant.pictureId}',
                  fit: BoxFit.cover,
                  height: 180,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 8),
            TitleText(text: restaurant.name),
            const SizedBox(height: 4),
            TextIcon(text: restaurant.city, icon: Icons.location_on),
            const SizedBox(height: 4),
            TextIcon(text: restaurant.rating.toString(), icon: Icons.star),
          ],
        ),
      ),
    );
  }
}
