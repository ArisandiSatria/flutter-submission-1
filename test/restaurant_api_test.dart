import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([http.Client])
void main() {
  group('Testing API Restfo', () {
    test('should return restaurant correctly', () async {
      final client = MockClient((request) async {
        final response = {
          "error": false,
          "message": "success",
          "count": 20,
          "restaurants": []
        };
        return http.Response(json.encode(response), 200);
      });

      final apiService = Api(httpClient: client);
      final result = await apiService.fetchRestaurants();

      expect(result, isA<RestaurantResult>());
    });
  });
}
