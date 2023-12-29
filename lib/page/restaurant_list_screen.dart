import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_category.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

class RestaurantListPage extends StatefulWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  List<Restaurant>? restaurant;

  String _searchQuery = '';
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
              )
            ],
          ),
        ),
        body: Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            // final filteredRestaurants = restaurant!
            //     .where((r) =>
            //         r.name.toLowerCase().contains(_searchQuery.toLowerCase()))
            //     .toList();
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              debugPrint(state.result.message.toString());
              return Text("OK");
              // return ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: state.result.restaurants.length,
              //   itemBuilder: (context, index) {
              //     var restaurant = state.result.restaurants[index];
              //     return SingleChildScrollView(
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           _banner(),
              //           ListView.builder(
              //             shrinkWrap: true,
              //             physics: const ClampingScrollPhysics(),
              //             itemCount: state.result.retaurants.length,
              //             itemBuilder: (context, index) {
              //               return _buildRestaurantItem(
              //               context, retaurants[index]);
              //             },
              //           )
              //         ],
              //       ),
              //     );
              //   },
              // );
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Material(
                  child: Text(state.message),
                ),
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Material(
                  child: Text(state.message),
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
        )
        );
  }

  Padding _banner() {
    return Padding(
        padding: const EdgeInsets.only(right: 17, left: 17, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Kategori",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            _restaurantCategoryList(),
            const SizedBox(height: 17),
            const Text(
              "Cari Restoran",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 17),
            _search(),
            const SizedBox(height: 17),
            const Text(
              "Daftar Restoran",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ));
  }

  Container _search() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Cari Restoran...',
          hintStyle: const TextStyle(color: Color(0xffDDDADA), fontSize: 12),
          prefixIcon: InkWell(
            onTap: () {},
            child: const Icon(
              Icons.search,
              size: 32,
              color: Colors.deepPurple,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        // controller: _searchQueryController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
      ),
    );
  }

  Container _restaurantCategoryList() {
    return Container(
      height: 100,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: restaurantCategoryList.map((category) {
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: InkWell(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          category.imageAsset,
                          fit: BoxFit.cover,
                          scale: 12,
                        ),
                        const SizedBox(
                          height: 11,
                        ),
                        Text(
                          category.name,
                          style: const TextStyle(fontSize: 12),
                        )
                      ]),
                ),
              ),
            );
          }).toList()),
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
