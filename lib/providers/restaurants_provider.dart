import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/api.dart';
import 'package:restaurant_app/models/base_response.dart';
import 'package:restaurant_app/models/restaurant.dart';

class RestaurantsProvider extends ChangeNotifier {
  bool isLoading = true;
  String error = '';

  BaseResponseData baseResponseData = BaseResponseData(
    error: false,
    message: '',
    restaurants: [],
  );

  BaseResponse baseResponse = BaseResponse(
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

  void getRestaurantList() async {
    try {
      final response = await http.get(Uri.parse('${Api.base_url}/list'));
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resData = jsonDecode(response.body);
        baseResponseData = BaseResponseData.fromJson(resData);
      } else {
        throw Exception(
          'status code: ${response.statusCode}\nSomething went wrong. Please try again later.',
        );
      }
    } catch (e) {
      // error = e.toString();
      error = 'Error while fetching data. Please try again later.';
    }
    isLoading = false;
    notifyListeners();
  }

  void getRestaurantById(String id) async {
    try {
      final response = await http.get(Uri.parse('${Api.base_url}/detail/$id'));
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resData = jsonDecode(response.body);
        baseResponse = BaseResponse.fromJson(resData);
      } else {
        throw Exception(
          'status code: ${response.statusCode}\nSomething went wrong. Please try again later.',
        );
      }
    } catch (e) {
      error = 'Error while fetching data. Please try again later.';
    }
    isLoading = false;
    notifyListeners();
  }
}
