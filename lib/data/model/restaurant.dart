import 'dart:convert';

class Welcome {
  final bool error;
  final String message;
  final Restaurant restaurant;

  Welcome({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
    );
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final Category categories;
  final Menus menus;
  final double rating;
  final CustomerReview customerReviews;

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
      address: restaurant['address'],
      pictureId: restaurant['pictureId'],
      categories: Category.fromJson(restaurant['categories']),
      menus: Menus.fromJson(restaurant['menus']),
      rating: restaurant['rating'].toDouble(),
      customerReviews: CustomerReview.fromJson(restaurant['review']));
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
  final List<Drink> foods;
  final List<Drink> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) {
    final foods = (json['foods'] as List<dynamic>)
        .map((food) => Drink.fromJson(food))
        .toList();

    final drinks = (json['drinks'] as List<dynamic>)
        .map((drink) => Drink.fromJson(drink))
        .toList();

    return Menus(foods: foods, drinks: drinks);
  }
}

class Drink {
  final String name;

  Drink({
    required this.name,
  });

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(name: json['name']);
  }
}

List<Restaurant> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }
  final Map<String, dynamic> parsed = jsonDecode(json);
  List<dynamic> restaurants = parsed['restaurants'];
  return restaurants.map((json) => Restaurant.fromJson(json)).toList();
}
