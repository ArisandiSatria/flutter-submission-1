import 'dart:convert';
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';
import 'package:restaurant_app/data/model/search.dart';

class Api {
  static const _url = "https://restaurant-api.dicoding.dev";

  Future<Welcome> fetchRestaurantList() async {
    final response = await http.get(Uri.parse("$_url/list"));

    if (response.statusCode == 200) {
      return Welcome.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantResult> fetchRestaurants() async {
    final response = await http.get(Uri.parse("$_url/list"));

    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<DetailRestaurant> fetchRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_url/detail/$id"));

    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<RestaurantSearchResult> fetchRestaurantSearch(
      String searchQuery) async {
    final response = await http.get(Uri.parse("$_url/search?q=$searchQuery"));

    if (response.statusCode == 200) {
      return RestaurantSearchResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant');
    }
  }

  Future<http.Response> fetchRestaurantReview(String name, review) {
    return http.post(Uri.parse("$_url/review"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'review': review,
          'date': DateFormat('yyyy-MM-dd').format(DateTime.now())
        }));
  }
}
