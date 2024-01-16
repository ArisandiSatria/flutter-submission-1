import 'dart:convert';

class Welcome {
  final bool error;
  final String message;
  final Restaurant? restaurant;
  final List<Restaurant> restaurants;

  Welcome({
    required this.error,
    required this.message,
    required this.restaurant,
    required this.restaurants,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        error: json["error"],
        message: json["message"],
        restaurant: json['restaurant'] == null
            ? null
            : Restaurant.fromJson(json['restaurant']),
        restaurants: json['restaurants'] == null
            ? []
            : List<Restaurant>.from(
                json['restaurants'].map(
                  (x) => Restaurant.fromJson(x),
                ),
              ),
      );
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String city;
  final String? address;
  final String pictureId;
  final List<Category> categories;
  final Menus? menus;
  final double rating;
  final List<CustomerReview> customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> restaurant) => Restaurant(
        id: restaurant['id'],
        name: restaurant['name'],
        description: restaurant['description'],
        city: restaurant['city'],
        address: restaurant["address"] == null ? null : restaurant['address'],
        pictureId: restaurant['pictureId'],
        categories: restaurant["categories"] == null
            ? []
            : List<Category>.from(
                restaurant["categories"]!.map((x) => Category.fromJson(x))),
        menus: restaurant["menus"] == null
            ? null
            : Menus.fromJson(restaurant["menus"]),
        rating: restaurant['rating'].toDouble(),
        customerReviews: restaurant["customerReviews"] == null
            ? []
            : List<CustomerReview>.from(restaurant["customerReviews"]!
                .map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}

class Category {
  final String name;

  Category({
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> category) => Category(
        name: category["name"],
      );
}

class CustomerReview {
  final String name;
  final String review;
  final String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> review) =>
      CustomerReview(
          name: review['name'], review: review['review'], date: review['date']);
}

class Menus {
  final List<Category> foods;
  final List<Category> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: json["foods"] == null
            ? []
            : List<Category>.from(
                json["foods"]!.map((x) => Category.fromJson(x))),
        drinks: json["drinks"] == null
            ? []
            : List<Category>.from(
                json["drinks"]!.map((x) => Category.fromJson(x))),
      );
}

List<Restaurant> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }
  final Map<String, dynamic> parsed = jsonDecode(json);
  List<dynamic> restaurants = parsed['restaurants'];
  return restaurants.map((json) => Restaurant.fromJson(json)).toList();
}
