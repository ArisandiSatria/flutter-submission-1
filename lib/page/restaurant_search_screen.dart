import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/data/result_state.dart';
import 'package:restaurant_app/widget/restaurant_item.dart';

class RestaurantSearch extends StatefulWidget {
  static const routeName = '/restaurant-search';
  const RestaurantSearch({super.key});

  @override
  State<RestaurantSearch> createState() => _RestaurantSearchState();
}

class _RestaurantSearchState extends State<RestaurantSearch> {
  final TextEditingController _searchController = TextEditingController();

  Future<void> _searchRestaurants(BuildContext context) async {
    if (_searchController.text.isNotEmpty) {
      Provider.of<SearchProvider>(context, listen: false)
          .fetchSearchRestaurant(_searchController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Cari Restoran...',
          ),
          onSubmitted: (String s) {
            setState(() {
              _searchRestaurants(context);
            });
          },
        ),
        actions: [
          _searchController.text.isEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.search,
                    size: 32,
                    color: Colors.deepPurple,
                  ),
                  onPressed: () {
                    _searchRestaurants(context);
                  },
                )
              : IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 32,
                    color: Colors.deepPurple,
                  ),
                  onPressed: () {
                    setState(() {
                      _searchController.text = "";
                    });
                  },
                )
        ],
      ),
      body: Consumer<SearchProvider>(
        builder: (context, searchProvider, _) {
          if (searchProvider.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (searchProvider.state == ResultState.hasData) {
            return _content(searchProvider.result.restaurants, context);
          } else if (searchProvider.state == ResultState.noData) {
            return Center(
              child: Material(
                child: Text(
                  searchProvider.message,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            );
          } else if (searchProvider.state == ResultState.error) {
            return Center(
              child: Material(
                  child: Text(searchProvider.message,
                      style: const TextStyle(color: Colors.grey))),
            );
          } else {
            return const Center(
              child: Material(
                child: Text(''),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _content(List<Restaurant> restaurant, BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: restaurant.length,
      itemBuilder: (context, index) {
        final restaurantItem = restaurant[index];
        return RestaurantItem(
          restaurant: restaurantItem,
        );
      },
    );
  }
}
