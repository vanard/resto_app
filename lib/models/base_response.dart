import 'package:restaurant_app/models/restaurant.dart';

class BaseResponse {
  final bool error;
  final String message;
  final Restaurant restaurant;

  BaseResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      error: json['error'] as bool,
      message: json['message'] as String,
      // Check if 'restaurant' key exists and is not null before parsing.
      // If it's null, we return null for the restaurant property.
      restaurant: Restaurant.fromJson(
        json['restaurant'] as Map<String, dynamic>,
      ),
    );
  }
}

class BaseResponseData {
  final bool error;
  final String message;
  final int? count;
  final int? founded;
  final List<Restaurant> restaurants;

  BaseResponseData({
    this.count,
    this.founded,
    required this.error,
    required this.message,
    required this.restaurants,
  });

  factory BaseResponseData.fromJson(Map<String, dynamic> json) {
    return BaseResponseData(
      error: json['error'] as bool,
      message: json['message'] as String,
      count: json['count'] as int?,
      founded: json['founded'] as int?,
      // Handle the list of restaurants.
      // Check if the 'restaurants' key exists and is a List.
      // If so, map each item in the list to a Restaurant object using its fromJson factory.
      restaurants: (json['restaurants'] as List<dynamic>)
          .map((item) => Restaurant.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
