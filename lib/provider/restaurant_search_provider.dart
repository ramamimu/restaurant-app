import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/restaurant_api.dart';
import 'package:restaurant_app/model/restaurant.dart';

import '../data/enum/ResultState.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final RestaurantAPI restaurantAPI;

  RestaurantSearchProvider({required this.restaurantAPI}) {
    getSearchedRestaurant('');
  }

  late ResultState _state;
  late List<Restaurant> _restaurantSearchList;

  ResultState get status => _state;

  List<Restaurant> get restaurantSearchList => _restaurantSearchList;

  Future getSearchedRestaurant(String query) async {
    if (kDebugMode) {
      print('i am triggered');
    }
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurants = await RestaurantAPI().restaurantSearch(query);
      notifyListeners();
      if (restaurants.isEmpty) {
        _state = ResultState.noData;
        _restaurantSearchList = [];
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        _restaurantSearchList = restaurants;
        notifyListeners();
      }
    } catch (err) {
      _state = ResultState.error;
      _restaurantSearchList = [];
      notifyListeners();
    }
  }
}
