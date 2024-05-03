import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';

import '../model/restaurant.dart';

class RestaurantTile extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantTile({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDetails(restaurant: restaurant),
          ),
        );
      },
      child: Card(
        child: ListTile(
          leading: Image.network(
            restaurant.pictureId,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return const Text("loading...");
            },
          ),
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
      ),
    );
  }
}
