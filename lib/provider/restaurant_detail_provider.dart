import 'package:flutter/foundation.dart';
import 'package:restaurant_app/model/restaurant.dart';

import '../data/api/restaurant_api.dart';
import '../data/enum/ResultState.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final RestaurantAPI restaurantAPI;
  final String restaurantId;

  RestaurantDetailProvider(
      {required this.restaurantAPI, required this.restaurantId}) {
    _getDetailRestaurant(restaurantId);
  }

  late ResultState _state;
  late Restaurant _detailRestaurant;

  ResultState get status => _state;

  Restaurant get detailRestaurant => _detailRestaurant;

  Future _getDetailRestaurant(String restaurantId) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      _detailRestaurant = await restaurantAPI.restaurantDetail(restaurantId);
      _state = ResultState.hasData;
      notifyListeners();
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      _state = ResultState.error;
      notifyListeners();
    }
  }
}
