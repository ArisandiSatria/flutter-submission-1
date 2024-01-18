import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/result_state.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/widget/restaurant_item.dart';

class RestaurantFavoritePage extends StatefulWidget {
  const RestaurantFavoritePage({super.key});

  @override
  State<RestaurantFavoritePage> createState() => _RestaurantFavoritePageState();
}

class _RestaurantFavoritePageState extends State<RestaurantFavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<FavoriteProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: provider.favorite.length,
            itemBuilder: (context, index) {
              return RestaurantItem(
                restaurant: provider.favorite[index],
              );
            },
          );
        } else {
          return Center(
            child: Material(
              child: Text(
                provider.message,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          );
        }
      },
    ));
  }
}
