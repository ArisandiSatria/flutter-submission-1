import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

enum ResultState { loading, noData, hasData, error }
 
class RestaurantProvider extends ChangeNotifier {
  final Api api;
 
  RestaurantProvider({required this.api}) {
    _fetchAllRestaurant();
  }
 
  late List<Restaurant> _restaurant;
  late ResultState _state;
  String _message = '';
 
  String get message => _message;

  List<Restaurant> get result => _restaurant;
 
  ResultState get state => _state;
 
  Future<void> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await api.fetchRestaurantList();
      debugPrint(response.toString());
      if (response.restaurants.isEmpty) {
        _state = ResultState.noData;
         _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;

        _restaurant = response.restaurants;
      }
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'Error --> $e';
    }
  }
}