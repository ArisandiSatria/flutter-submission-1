import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final Api api;

  RestaurantProvider({required this.api}) {
    _fetchAllRestaurant();
  }

  late List<Restaurant> _restaurants;
  late ResultState _state;
  String _message = '';

  List<Restaurant> get result => _restaurants;
  ResultState get state => _state;
  String get message => _message;

  Future<void> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await api.fetchRestaurantList();
      if (response.restaurants.isEmpty) {
        _state = ResultState.noData;
        _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        _restaurants = response.restaurants;
      }
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'No Internet Connection!';
    }
  }

  Future<void> fetchAllRestaurant() async {
    await _fetchAllRestaurant();
  }
}
