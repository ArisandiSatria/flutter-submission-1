import 'dart:convert';

// import 'package:flutter/material.dart';

class Welcome {
  final List<Restaurant> restaurants;

  Welcome({
    required this.restaurants,
  });

  factory Welcome.fromJson(Map<String, dynamic> welcome) => Welcome(
        restaurants: welcome['restaurants'],
      );
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> restaurant) => Restaurant(
      id: restaurant['id'],
      name: restaurant['name'],
      description: restaurant['description'],
      pictureId: restaurant['pictureId'],
      city: restaurant['city'],
      rating: restaurant['rating'].toDouble(),
      menus: Menus.fromJson(restaurant['menus']));
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
