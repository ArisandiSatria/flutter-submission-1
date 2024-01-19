import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';

class RestaurantItem extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantItem({
    super.key,
    required this.restaurant,
  });

  @override
  _RestaurantItemState createState() => _RestaurantItemState();
}

class _RestaurantItemState extends State<RestaurantItem> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    String? imageBaseUrl = 'https://restaurant-api.dicoding.dev/images/medium/';
    return Consumer<FavoriteProvider>(
      builder: (context, provider, child) {
        return FutureBuilder(
            future: provider.isFavorite(widget.restaurant.id),
            builder: (context, snapshot) {
              var isFavorited = snapshot.data ?? false;
              return Material(
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/restaurant-detail",
                          arguments: {
                            'restaurant': widget.restaurant,
                          },
                        );
                      },
                      child: Container(
                        height: 100,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 17, vertical: 5),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                '$imageBaseUrl${widget.restaurant.pictureId}',
                                width: 100,
                                errorBuilder: (ctx, error, _) =>
                                    const Center(child: Icon(Icons.error)),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.restaurant.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.place,
                                          color: Colors.deepPurple,
                                          size: 20,
                                        ),
                                        Text(
                                          widget.restaurant.city,
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
                                          widget.restaurant.rating.toString(),
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            isFavorited
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.deepPurple,
                                    ),
                                    onPressed: () {
                                      provider.removedFavorite(
                                          widget.restaurant.id.toString());
                                    },
                                  )
                                : IconButton(
                                    icon: const Icon(
                                      Icons.favorite_border,
                                      color: Colors.deepPurple,
                                    ),
                                    onPressed: () {
                                      provider.addRestaurant(widget.restaurant);
                                    },
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
