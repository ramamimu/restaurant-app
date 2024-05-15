import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../model/restaurant.dart';
import 'package:http/http.dart';

class RestaurantAPI {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  String listUrl() => "$_baseUrl/list";

  String detailUrl(String id) => "$_baseUrl/detail/$id";

  String searchUrl(String query) => "$_baseUrl/search?q=$query";

  Future<List<Restaurant>> restaurantList() async {
    final response = await get(Uri.parse(listUrl()));
    if (response.statusCode == 200) {
      var decodedJson = json.decode(response.body);
      List<dynamic> restaurantsJson = decodedJson['restaurants'];
      List<Restaurant> restaurants =
          restaurantsJson.map((json) => Restaurant.fromJson(json)).toList();
      return restaurants;
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<List<Restaurant>> restaurantSearch(String query) async {
    final response = await get(Uri.parse(searchUrl(query)));
    if (response.statusCode == 200) {
      var decodedJson = json.decode(response.body);
      List<dynamic> restaurantsJson = decodedJson['restaurants'];
      List<Restaurant> restaurants =
          restaurantsJson.map((json) => Restaurant.fromJson(json)).toList();
      return restaurants;
    } else {
      throw Exception('Failed to search restaurant');
    }
  }
}
