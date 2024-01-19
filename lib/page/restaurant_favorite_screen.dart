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
    return Scaffold(
      body: Consumer<FavoriteProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 17, left: 17, top: 20),
                child: Text(
                  "Daftar Restoran Favorit",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              if (provider.state == ResultState.hasData)
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.favorite.length,
                    itemBuilder: (context, index) {
                      return RestaurantItem(
                        restaurant: provider.favorite[index],
                      );
                    },
                  ),
                ),
              if (provider.state == ResultState.noData)
                Center(
                  child: Material(
                    child: Text(
                      provider.message,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
