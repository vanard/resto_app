import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/models/customer_review.dart';

class ApiService {
  static const _baseUrl = 'https://restaurant-api.dicoding.dev';
  static const imageSmallBaseUrl =
      'https://restaurant-api.dicoding.dev/images/small/';
  static const imageMediumBaseUrl =
      'https://restaurant-api.dicoding.dev/images/medium/';

  late final http.Client _client;

  ApiService({http.Client? client}) {
    _client = client ?? http.Client();
  }

  Future<Map<String, dynamic>> getRestaurantList() async {
    try {
      final response = await _client.get(Uri.parse('$_baseUrl/list'));
      debugPrint(response.body);
      debugPrint('status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw _handleError(response.statusCode);
      }
    } catch (e) {
      throw _handleException(e);
    }
  }

  Future<Map<String, dynamic>> getRestaurantById(String id) async {
    try {
      final response = await _client.get(Uri.parse('$_baseUrl/detail/$id'));
      debugPrint(response.body);
      debugPrint('status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw _handleError(response.statusCode);
      }
    } catch (e) {
      throw _handleException(e);
    }
  }

  Future<Map<String, dynamic>> addReview(
    String id,
    CustomerReview review,
  ) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/review'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(review.onAddReview(id)),
      );
      debugPrint(response.body);
      debugPrint('status code: ${response.statusCode}');
      if (response.statusCode == 201) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw _handleError(response.statusCode);
      }
    } catch (e) {
      throw _handleException(e);
    }
  }

  Future<Map<String, dynamic>> searchRestaurant(String query) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/search?q=$query'),
      );
      debugPrint(response.body);
      debugPrint('status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw _handleError(response.statusCode);
      }
    } catch (e) {
      throw _handleException(e);
    }
  }

  //

  static const messageToUser = 'Something went wrong. Please try again later.';
  static const suffixMessageToUser = '\nPlease try again later.';
  static const emptyRestaurantList = 'Restaurant is not found.';

  Exception _handleError(int statusCode) {
    switch (statusCode) {
      case 400:
        return Exception('Bad Request$suffixMessageToUser');
      case 401:
        return Exception('Unauthorized$suffixMessageToUser');
      case 403:
        return Exception('Forbidden$suffixMessageToUser');
      case 404:
        return Exception('Not Found$suffixMessageToUser');
      case 500:
        return Exception('Internal Server Error$suffixMessageToUser');
      default:
        return Exception(
          'Request failed with status: $statusCode$suffixMessageToUser',
        );
    }
  }

  Exception _handleException(dynamic error) {
    if (error is Exception) {
      debugPrint(error.toString());
      // return error;
      return Exception(messageToUser);
    }
    return Exception('Network error: $error$suffixMessageToUser');
  }

  void dispose() {
    _client.close();
  }
}
