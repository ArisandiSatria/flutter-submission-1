import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        resizeToAvoidBottomInset: false,
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
        body: GestureDetector(
          onTap: () {
            // Hide keyboard when tapped outside of the keyboard or text field
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: Consumer<SearchProvider>(
            builder: (context, searchProvider, _) {
              if (searchProvider.state == ResultState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (searchProvider.state == ResultState.hasData) {
                debugPrint(searchProvider.toString());
                return Text("TRUE");
              } else if (searchProvider.state == ResultState.noData) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.restaurant_menu,
                        size: 80,
                        color: Colors.grey,
                      ),
                      Text(
                        "Enter Restaurant Name",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/loupe.png',
                            fit: BoxFit.cover,
                            scale: 12,
                            color: Colors.grey,
                          ),
                          Text("Not Found")
                        ],
                      )),
                );
              }
            },
          ),
        ));
  }

  Widget _content(List<Restaurant> restaurant) {
    return ListView.builder(
      itemCount: restaurant.length,
      itemBuilder: (context, index) {
        return _buildRestaurantItem(context, restaurant[index]);
      },
    );
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
