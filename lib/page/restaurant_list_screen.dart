import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/page/restaurant_favorite_screen.dart';
import 'package:restaurant_app/page/setting_screen.dart';
import 'package:restaurant_app/widget/restaurant_item.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/data/result_state.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant-list';
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  bool isFavorite = false;

  int _currentIndex = 0;

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
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _homeScreen();
      case 1:
        return const RestaurantFavoritePage();
      case 2:
        return const SettingPage();
      default:
        return Container();
    }
  }

  Widget _homeScreen() {
    return Consumer<RestaurantProvider>(
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
          return Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/loupe.png',
                      fit: BoxFit.cover,
                      scale: 12,
                      color: Colors.grey,
                    ),
                    const Text("No Data")
                  ],
                )),
          );
        }
      },
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
                  return const Padding(
                    padding: EdgeInsets.only(right: 17, left: 17, top: 20),
                    child: Text(
                      "Daftar Restoran",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  );
                } else {
                  final restaurantItem = restaurant[index - 1];
                  return RestaurantItem(
                    restaurant: restaurantItem,
                  );
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
}
