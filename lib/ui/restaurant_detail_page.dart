import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';

class RestaurantDetails extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetails({super.key, required this.restaurant});

  Widget borderRadiusMenu(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Detail Restaurant',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: NetworkImage(restaurant.pictureId),
                ),
                const SizedBox(height: 20),
                Text(
                  restaurant.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w700),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 15,
                      color: Colors.black12,
                    ),
                    Text(
                      restaurant.city,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black38,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 15,
                      color: Colors.black12,
                    ),
                    Text(
                      restaurant.rating.toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black38,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  restaurant.description,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20),
                Container(
                  color: Colors.black12,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 2,
                  ),
                  child: const Text(
                    "Menu",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                borderRadiusMenu("Foods"),
                const SizedBox(height: 10),
                Wrap(
                  runSpacing: 5,
                  spacing: 5,
                  children: restaurant.menus.foods
                      .map((e) => borderRadiusMenu(e.name))
                      .toList(),
                ),
                const SizedBox(height: 30),
                borderRadiusMenu("Drinks"),
                const SizedBox(height: 10),
                Wrap(
                  runSpacing: 5,
                  spacing: 5,
                  children: restaurant.menus.drinks
                      .map((e) => borderRadiusMenu(e.name))
                      .toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
