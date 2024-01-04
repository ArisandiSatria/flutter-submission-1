import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class SearchProvider extends ChangeNotifier {
  final Api api;
  final String name;

  SearchProvider({required this.api, this.name = ''}) {
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
      if (name.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'Enter Restaurant Name';
      }
      _state = ResultState.loading;
      notifyListeners();
      final response = await api.fetchRestaurantSearch(name);
      print(response);
      _state = ResultState.hasData;
      notifyListeners();
      _restaurants = response.restaurants;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'Check Your Internet Connection !';
    }
  }
}
