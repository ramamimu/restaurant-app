import 'package:flutter/material.dart';

import '../model/restaurant.dart';

class RestaurantTile extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantTile({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(restaurant.pictureId),
        title: Text(restaurant.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.star),
                Text(restaurant.rating.toString()),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.location_on),
                Text(restaurant.city),
              ],
            )
          ],
        ),
      ),
    );
  }
}
