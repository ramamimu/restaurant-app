import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/widgets/restaurant_tile.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  late List<Restaurant> restaurants;

  @override
  void initState() {
    loadJsonData();
    super.initState();
  }

  void loadJsonData() async {
    String stringJson = await DefaultAssetBundle.of(context)
        .loadString('assets/local_restaurant.json');
    Map<String, dynamic> parsedJson = jsonDecode(stringJson);

    List<dynamic> listRestaurant = parsedJson['restaurants'];
    setState(() {
      restaurants = listRestaurant.map((e) {
        return Restaurant.fromJson(e);
      }).toList();
    });
    if (kDebugMode) {
      print(parsedJson['restaurants'].length);
    }
  }

  Future readJson(String path) async {
    final String response = await rootBundle.loadString(path);
    return await json.decode(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin:
          const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Restaurant",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                const Text(
                  "Recommendation restaurant for you!",
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: restaurants.map((e) {
                    return RestaurantTile(restaurant: e);
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
