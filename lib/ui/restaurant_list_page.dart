import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/api/restaurant_api.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widgets/restaurant_tile.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  List<Restaurant> restaurants = [];
  bool isRestaurantListLoading = true;
  String loadingText = "loading...";

  @override
  void initState() {
    super.initState();
  }

  Future readJson(String path) async {
    final String response = await rootBundle.loadString(path);
    return await json.decode(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<RestaurantProvider>(
        create: (_) => RestaurantProvider(restaurantAPI: RestaurantAPI()),
        child: SafeArea(
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
                  restaurantList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget restaurantList() {
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
