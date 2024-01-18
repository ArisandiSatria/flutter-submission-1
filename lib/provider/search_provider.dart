import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/search.dart';
import 'package:restaurant_app/data/result_state.dart';

class SearchProvider extends ChangeNotifier {
  final Api api;
  final String name;

  SearchProvider({required this.api, this.name = ''}) {
    _restaurants =
        RestaurantSearchResult(restaurants: [], error: false, founded: 0);
    _state = ResultState.noData;
  }

  late RestaurantSearchResult _restaurants;
  late ResultState _state;
  String _message = '';

  RestaurantSearchResult get result => _restaurants;
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
      if (response.restaurants.isEmpty && response.founded == 0) {
        _state = ResultState.noData;
        _message = 'No Restaurant';
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        _restaurants = response;
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'Check Your Internet Connection!';
    }
  }
}
