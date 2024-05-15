import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/widgets/restaurant_tile.dart';

import '../provider/restaurant_provider.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(builder: (context, state, _) {
      if (state.status == ResultState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state.status == ResultState.hasData) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: state.restaurantList.map((e) {
            return RestaurantTile(restaurant: e);
          }).toList(),
        );
      } else if (state.status == ResultState.noData) {
        return const Center(
          child: Material(
            child: Text('restaurant have no data'),
          ),
        );
      } else if (state.status == ResultState.error) {
        return const Center(
          child: Material(
            child: Text('error while getting the data'),
          ),
        );
      } else {
        return const Center(
          child: Material(
            child: Text(''),
          ),
        );
      }
    });
  }
}
