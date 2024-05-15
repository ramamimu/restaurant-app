import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';

import '../data/api/restaurant_api.dart';
import '../data/enum/ResultState.dart';

class RestaurantDetails extends StatefulWidget {
  final String restaurantId;

  const RestaurantDetails({super.key, required this.restaurantId});

  @override
  State<RestaurantDetails> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  late Restaurant restaurant;
  late ResultState status;

  @override
  void initState() {
    super.initState();
    // getRestaurant();
  }

  Future getRestaurant() async {
    try {
      setState(() {
        status = ResultState.loading;
      });
      final response = (await get(
          Uri.parse(RestaurantAPI().detailUrl(widget.restaurantId))));
      if (kDebugMode) {
        print(RestaurantAPI().detailUrl(widget.restaurantId));
        print(response.statusCode);
      }
      if (response.statusCode == 200) {
        var decodedJson = json.decode(response.body);
        dynamic restaurantJson = decodedJson['restaurant'];
        setState(() {
          restaurant = Restaurant.fromJson(restaurantJson);
          status = ResultState.hasData;
        });
      } else {
        setState(() {
          status = ResultState.noData;
        });
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      setState(() {
        status = ResultState.error;
      });
    }
  }

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

  Widget restaurantDetailConsumer(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(builder: (context, state, _) {
      return state.status == ResultState.hasData
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      "https://restaurant-api.dicoding.dev/images/medium/${state.detailRestaurant.pictureId}",
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Text("loading...");
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      state.detailRestaurant.name,
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
                          state.detailRestaurant.city,
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
                          state.detailRestaurant.rating.toString(),
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
                      state.detailRestaurant.description,
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
                      children: state.detailRestaurant.menus!.foods
                          .map((e) => borderRadiusMenu(e.name))
                          .toList(),
                    ),
                    const SizedBox(height: 30),
                    borderRadiusMenu("Drinks"),
                    const SizedBox(height: 10),
                    Wrap(
                      runSpacing: 5,
                      spacing: 5,
                      children: state.detailRestaurant.menus!.drinks
                          .map((e) => borderRadiusMenu(e.name))
                          .toList(),
                    )
                  ],
                ),
              ),
            )
          : state.status == ResultState.loading
              ? const Center(child: CircularProgressIndicator())
              : const Center(
                  child: Text("Failed getting detail restaurant"),
                );
    });
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
      body: ChangeNotifierProvider<RestaurantDetailProvider>(
        create: (_) => RestaurantDetailProvider(
            restaurantAPI: RestaurantAPI(), restaurantId: widget.restaurantId),
        child: SafeArea(
          child: restaurantDetailConsumer(context),
        ),
      ),
    );
  }
}
