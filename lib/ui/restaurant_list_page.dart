import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/restaurant_search_page.dart';
import 'package:restaurant_app/widgets/restaurant_list.dart';

import '../data/api/restaurant_api.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Restaurant",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SearchPage()));
                          },
                          child: const Icon(Icons.search))
                    ],
                  ),
                  const Text(
                    "Recommendation restaurant for you!",
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const RestaurantList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
