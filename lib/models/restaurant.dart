import 'package:restaurant_app/models/customer_review.dart';

class BaseResponse {
  final bool error;
  final String message;
  final int? count;
  final int? founded;
  final Restaurant restaurant;

  BaseResponse({
    this.count,
    this.founded,
    required this.error,
    required this.message,
    required this.restaurant,
  });
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String city;
  final String? address;
  final String pictureId;
  final List<Type>? categories;
  final Menus? menus;
  final double rating;
  final List<CustomerReview>? customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    this.address,
    required this.pictureId,
    this.categories,
    this.menus,
    required this.rating,
    this.customerReviews,
  });
}

class Type {
  final String name;

  Type({required this.name});
}

class Menus {
  final List<Type> foods;
  final List<Type> drinks;

  Menus({required this.foods, required this.drinks});
}
