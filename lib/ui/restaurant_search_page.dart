import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/api/restaurant_api.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

import '../widgets/restaurant_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  late ResultState status;
  late List<Restaurant> restaurantSearchList;

  @override
  void initState() {
    // TODO: implement initState
    getSearchedRestaurant();
    super.initState();
  }

  Future getSearchedRestaurant() async {
    try {
      setState(() {
        status = ResultState.loading;
      });
      final restaurants =
          await RestaurantAPI().restaurantSearch(_searchController.text.trim());
      if (restaurants.isEmpty) {
        setState(() {
          status = ResultState.noData;
          restaurantSearchList = [];
        });
      } else {
        setState(() {
          status = ResultState.hasData;
          restaurantSearchList = restaurants;
        });
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      setState(() {
        status = ResultState.error;
        restaurantSearchList = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey, Colors.purple.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: TextField(
          onChanged: (_) {
            getSearchedRestaurant();
          },
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: showRestaurantList())),
    );
  }

  Widget showRestaurantList() {
    if (status == ResultState.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (status == ResultState.hasData) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: restaurantSearchList.map((e) {
          return RestaurantTile(restaurant: e);
        }).toList(),
      );
    } else if (status == ResultState.noData) {
      return const Center(
        child: Material(
          child: Center(child: Text('restaurant have no data')),
        ),
      );
    } else if (status == ResultState.error) {
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
  }
}
