import 'package:restaurant_app/models/customer_review.dart';

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

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      city: json['city'] as String,
      address: json['address'] as String?, // Nullable field
      pictureId: json['pictureId'] as String,
      rating: (json['rating'] as num).toDouble(),
      // Handle nested lists and objects, checking for nullability
      categories: (json['categories'] as List<dynamic>?)
          ?.map((item) => Type.fromJson(item as Map<String, dynamic>))
          .toList(),
      menus: json['menus'] != null
          ? Menus.fromJson(json['menus'] as Map<String, dynamic>)
          : null,
      customerReviews: (json['customerReviews'] as List<dynamic>?)
          ?.map((item) => CustomerReview.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Type {
  final String name;

  Type({required this.name});

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(name: json['name'] as String);
  }
}

class Menus {
  final List<Type> foods;
  final List<Type> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods: (json['foods'] as List<dynamic>)
          .map((item) => Type.fromJson(item as Map<String, dynamic>))
          .toList(),
      drinks: (json['drinks'] as List<dynamic>)
          .map((item) => Type.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
