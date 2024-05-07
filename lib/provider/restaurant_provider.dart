import 'package:flutter/foundation.dart';
import 'package:restaurant_app/api/restaurant_api.dart';

import '../model/restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final RestaurantAPI restaurantAPI;

  RestaurantProvider({required this.restaurantAPI}) {
    _getAllRestaurant();
  }

  late List<Restaurant> _restaurantList;

  late ResultState _state;

  List<Restaurant> get restaurantList => _restaurantList;

  ResultState get status => _state;

  Future<List<Restaurant>> _getAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurants = await restaurantAPI.restaurantList();
      if (restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return [];
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _restaurantList = restaurants;
        return restaurants;
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      _state = ResultState.error;
      notifyListeners();
      return [];
    }
  }
}
