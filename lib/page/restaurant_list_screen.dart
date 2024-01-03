import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:flutter/gestures.dart';

class RestaurantListPage extends StatefulWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Restfo",
                style: TextStyle(
                    color: Colors.deepPurple, fontWeight: FontWeight.w600)),
            Text(
              "Temukan restoran pilihan anda dengan mudah!",
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 32,
              color: Colors.deepPurple,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/restaurant-search");
            },
          ),
        ],
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            var restaurant =
                state.result.map((restaurant) => restaurant).toList();
            return _content(restaurant, state);
          } else if (state.state == ResultState.noData) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else if (state.state == ResultState.error) {
            return Center(child: _buildErrorContent(state.message));
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

  Widget _content(List<Restaurant> restaurant, RestaurantProvider state) {
    return RefreshIndicator(
      color: Colors.white,
      backgroundColor: Colors.deepPurple,
      onRefresh: () async {
        await state.fetchAllRestaurant();
      },
      child: state.state == ResultState.error
          ? _buildErrorContent(state.message)
          : ListView.builder(
              itemCount: restaurant.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _banner();
                } else {
                  final restaurantItem = restaurant[index - 1];
                  return _buildRestaurantItem(context, restaurantItem);
                }
              },
            ),
    );
  }

  Widget _buildErrorContent(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorMessage),
          ElevatedButton(
            onPressed: () async {
              await Provider.of<RestaurantProvider>(context, listen: false)
                  .fetchAllRestaurant();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Padding _banner() {
    return const Padding(
        padding: EdgeInsets.only(right: 17, left: 17, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Daftar Restoran",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ));
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
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
                    restaurant.pictureId,
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
