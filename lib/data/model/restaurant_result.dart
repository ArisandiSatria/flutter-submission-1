import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantResult {
  RestaurantResult({
    required this.message,
    required this.founded,
    required this.restaurants,
    required this.restaurant,
  });

  final String message;
  final int founded;
  final List<Restaurant> restaurants;
  final Restaurant? restaurant;

  factory RestaurantResult.fromJson(Map<String, dynamic> json) =>
      RestaurantResult(
          message: json['message'] ?? "",
          founded: json['founded'] ?? 0,
          restaurants: json['restaurants'] == null
              ? []
              : List<Restaurant>.from(
                  json['restaurants'].map(
                    (x) => Restaurant.fromJson(x),
                  ),
                ),
          restaurant: json['restaurant'] == null
              ? null
              : Restaurant.fromJson(json['restaurant']));
}
