import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/search_provider.dart';

class RestaurantSearch extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  RestaurantSearch({super.key});

  Future<void> _searchRestaurants(BuildContext context) async {
    String searchQuery = _searchController.text;
    if (searchQuery.isNotEmpty) {
      Provider.of<SearchProvider>(context, listen: false)
          .fetchSearchRestaurant(searchQuery);
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
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 32,
              color: Colors.deepPurple,
            ),
            onPressed: () {
              _searchRestaurants(context);
            },
          ),
        ],
      ),
      body: Consumer<SearchProvider>(
          builder: (context, searchProvider, _) {
            if (searchProvider.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (searchProvider.state == ResultState.hasData) {
              return _content(searchProvider.result);
            } else if (searchProvider.state == ResultState.noData) {
              return Center(
                child: Material(
                  child: Text(searchProvider.message),
                ),
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

  Widget _content(List<Restaurant> restaurant) {
    return ListView.builder(
      itemCount: restaurant.length,
      itemBuilder: (context, index) {
        return _buildRestaurantItem(restaurant: restaurant[index]);
      },
    );
  }

  Widget _buildRestaurantItem(Restaurant restaurant) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/restaurant-detail",
                arguments: restaurant);
          },
          child: Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    restaurant.name,
                    width: 100,
                    errorBuilder: (ctx, error, _) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        restaurant.name,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.place,
                            color: Colors.deepPurple,
                            size: 20,
                          ),
                          Text(
                            restaurant.city,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          Text(
                            restaurant.rating.toString(),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
