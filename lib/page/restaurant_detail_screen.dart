import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/detail_provider.dart';

class RestaurantDetailPage extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<DetailProvider>(context, listen: false)
          .fetchDetailRestaurant(widget.restaurant.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailProvider(
        api: Api(),
        id: widget.restaurant.id,
      ),
      child: Scaffold(
        body: Consumer<DetailProvider>(
          builder: (context, state, child) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              return SafeArea(
                bottom: false,
                child: SingleChildScrollView(
                    child: Stack(
                  children: [
                    Column(
                      children: [
                        Image.network(
                          state.detailResult.restaurant.pictureId,
                          width: MediaQuery.of(context).size.width,
                          height: 350,
                          fit: BoxFit.cover,
                        ),
                        _content(state.detailResult.restaurant),
                      ],
                    ),
                    _navButton(context),
                  ],
                )),
              );
            } else if (state.state == ResultState.noData) {
              return Scaffold(
                body: Center(
                  child: Text(state.message),
                ),
              );
            } else if (state.state == ResultState.error) {
              return Scaffold(
                body: Center(
                  child: Text(state.message),
                ),
              );
            } else {
              return const Scaffold(
                body: Center(
                  child: Text('Please try again later'),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Padding _content(Restaurant restaurant) {
    debugPrint(restaurant.menus?.drinks.length.toString());
    return Padding(
      padding: const EdgeInsets.all(17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 5,
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
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Text(
                    restaurant.rating.toString(),
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.deepPurple,
          ),
          SizedBox(
            height: 10,
          ),
          Text("Kategori", style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: restaurant.categories?.map((resto) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          resto.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  }).toList() ??
                  [],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Deskripsi", style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(
            height: 17,
          ),
          Text(restaurant.description, style: TextStyle(fontSize: 13)),
          SizedBox(width: 10),
          SizedBox(
            height: 10,
          ),
          Text("Makanan", style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(
            height: 17,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: restaurant.menus?.foods.map((food) {
                    return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          width: 125,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/no-food.png',
                                  fit: BoxFit.cover,
                                  scale: 12,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 11,
                                ),
                                Text(
                                  food.name,
                                  style: TextStyle(fontSize: 12),
                                )
                              ]),
                        ));
                  }).toList() ??
                  [],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Minuman", style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(
            height: 17,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: restaurant.menus?.drinks.map((drink) {
                    return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          width: 125,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/no-food.png',
                                  fit: BoxFit.cover,
                                  scale: 12,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 11,
                                ),
                                Text(
                                  drink.name,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                              ]),
                        ));
                  }).toList() ??
                  [],
            ),
          )
        ],
      ),
    );
  }

  Padding _navButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 24, right: 24),
      child: CircleAvatar(
        backgroundColor: Colors.deepPurple,
        radius: 25,
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
