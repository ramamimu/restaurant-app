import 'dart:convert';

import 'package:http/http.dart';

import '../../model/restaurant.dart';

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

  Future<Restaurant> restaurantDetail(String restaurantId) async {
    final response = await get(Uri.parse(detailUrl(restaurantId)));
    if (response.statusCode == 200) {
      var decodedJson = json.decode(response.body);
      dynamic restaurantJson = decodedJson['restaurant'];
      Restaurant restaurant = Restaurant.fromJson(restaurantJson);
      return restaurant;
    } else {
      throw Exception('failed to get detail restaurant');
    }
  }
}
