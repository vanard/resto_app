import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api_service.dart';
import 'package:restaurant_app/models/base_response.dart';
import 'package:restaurant_app/models/customer_review.dart';
import 'package:restaurant_app/models/restaurant.dart';

class RestaurantsProvider extends ChangeNotifier {
  late final ApiService _apiService;
  bool _isLoading = true;
  String _error = '';
  Map<String, dynamic>? _remoteData;

  RestaurantsProvider({required ApiService apiService})
    : _apiService = apiService;

  bool get isLoading => _isLoading;
  String get error => _error;
  Map<String, dynamic>? get data => _remoteData;

  ResponseRestaurants baseResponseData = ResponseRestaurants(
    error: false,
    message: '',
    restaurants: [],
  );

  ResponseRestaurant baseResponse = ResponseRestaurant(
    error: false,
    message: '',
    restaurant: Restaurant(
      id: '',
      name: '',
      description: '',
      city: '',
      pictureId: '',
      rating: 0.0,
    ),
  );

  ResponseReviews responseReviews = ResponseReviews(
    error: false,
    message: '',
    reviews: [],
  );

  void fetchRestaurantList() async {
    _isLoading = true;

    try {
      _remoteData = await _apiService.getRestaurantList();
      baseResponseData = ResponseRestaurants.fromJson(_remoteData!);
      _error = '';
    } catch (e) {
      debugPrint('Error: $e');
      _error = ApiService.messageToUser;
      _remoteData = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void fetchRestaurantById(String id) async {
    _isLoading = true;

    try {
      _remoteData = await _apiService.getRestaurantById(id);
      baseResponse = ResponseRestaurant.fromJson(_remoteData!);
      _error = '';
    } catch (e) {
      debugPrint('Error: $e');
      _error = ApiService.messageToUser;
      _remoteData = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addCustomerReview(String restoId, CustomerReview review) async {
    _isLoading = true;

    try {
      _remoteData = await _apiService.addReview(restoId, review);
      responseReviews = ResponseReviews.fromJson(_remoteData!);
      baseResponse.restaurant.customerReviews = responseReviews.reviews;
      _error = '';
    } catch (e) {
      debugPrint('Error: $e');
      _error = ApiService.messageToUser;
      _remoteData = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchRestaurants(String query) async {
    _isLoading = true;

    try {
      _remoteData = await _apiService.searchRestaurant(query);
      final founded = _remoteData!['founded'];
      debugPrint('Found: ${_remoteData!['founded']}');
      if (founded == 0) {
        baseResponseData = ResponseRestaurants(
          error: false,
          message: '',
          restaurants: [],
        );
        _error = ApiService.emptyRestaurantList;
      } else {
        baseResponseData = ResponseRestaurants.fromJson(_remoteData!);
        _error = '';
      }
    } catch (e) {
      debugPrint('Error: $e');
      _error = ApiService.messageToUser;
      _remoteData = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
