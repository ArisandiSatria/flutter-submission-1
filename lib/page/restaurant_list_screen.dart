import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/model/restaurant_category.dart';

class RestaurantListPage extends StatefulWidget {
  RestaurantListPage({Key? key}) : super(key: key);

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
          title: Column(
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
        body: FutureBuilder<String>(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/local_restaurant.json'),
            builder: (context, snapshot) {
              restaurant = parseRestaurant(snapshot.data);
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 17, left: 17, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kategori",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            _restaurantCategoryList(),
                            SizedBox(height: 17),
                            Text(
                              "Cari Restoran",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 17),
                            _search(),
                            SizedBox(height: 17),
                            Text(
                              "Daftar Restoran",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: restaurant!
                          .where((r) => r.name
                              .toLowerCase()
                              .contains(_searchQuery.toLowerCase()))
                          .length,
                      itemBuilder: (context, index) {
                        final filteredRestaurants = restaurant!
                            .where((r) => r.name
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase()))
                            .toList();
                        return _buildRestaurantItem(
                            context, filteredRestaurants[index]);
                      },
                    )
                  ],
                ),
              );
            }));
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
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.all(15),
          hintText: 'Cari Restoran...',
          hintStyle: TextStyle(color: Color(0xffDDDADA), fontSize: 12),
          prefixIcon: InkWell(
            onTap: () {},
            child: Icon(
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
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: InkWell(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            category.imageAsset,
                            fit: BoxFit.cover,
                            scale: 12,
                          ),
                          SizedBox(
                            height: 11,
                          ),
                          Text(
                            category.name,
                            style: TextStyle(fontSize: 12),
                          )
                        ]),
                  ),
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
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/restaurant-detail",
                arguments: restaurant);
          },
          child: Container(
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 17, vertical: 5),
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
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.place,
                            color: Colors.deepPurple,
                            size: 20,
                          ),
                          Text(
                            restaurant.city,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          Text(
                            restaurant.rating.toString(),
                            style: TextStyle(fontSize: 12),
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
