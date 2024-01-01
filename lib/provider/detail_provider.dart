import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class DetailProvider extends ChangeNotifier {
  final Api api;
  final String id;
  DetailProvider({required this.api, this.id = ''}){
    fetchDetailRestaurant(id);
  }

  late DetailRestaurant _restaurant;
  late ResultState _state;
  String _message = '';

  DetailRestaurant get detailResult => _restaurant;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> fetchDetailRestaurant(String id) async {
    try {
      if (id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No Data Restaurant Found';
      }
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await api.fetchRestaurantDetail(id);
      _state = ResultState.hasData;
      notifyListeners();
      return _restaurant = restaurant;

    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Check Your Internet Connection !';
    }
  }

  // Future<void> fetchRestaurantDetail(id) async {
  //   await _fetchRestaurantDetail(id);
  // }
}
