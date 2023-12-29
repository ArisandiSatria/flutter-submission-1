import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final Api api;

  RestaurantProvider({required this.api}) {
    _fetchAllRestaurant();
  }

  late Welcome _restaurant;
  late ResultState _state = ResultState.loading; // Provide an initial value here
  String _message = '';

  String get message => _message;

  Welcome get result => _restaurant;

  ResultState get state => _state;

  Future<void> _fetchAllRestaurant() async {
      final response = await api.fetchRestaurantList();
      debugPrint(response.toString());
    try {
      
      _state = ResultState.loading;
      notifyListeners();

      if (response.restaurant == null) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _restaurant = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'Error --> $e';
    }
  }
}
