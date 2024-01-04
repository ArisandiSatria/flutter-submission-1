import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class SearchProvider extends ChangeNotifier {
  final Api api;
  late final String name;

  SearchProvider({required this.api, this.name = ''}) {
    _restaurants = [];
    fetchSearchRestaurant(name);
  }

  late List<Restaurant> _restaurants;
  late ResultState _state;
  String _message = '';

  List<Restaurant> get result => _restaurants;
  ResultState get state => _state;
  String get message => _message;

  Future<void> fetchSearchRestaurant(String name) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await api.fetchRestaurantSearch(name);
      debugPrint(response.restaurants.length.toString());
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
}
