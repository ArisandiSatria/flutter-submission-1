import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';
import 'package:restaurant_app/page/setting_screen.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/schedulling_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([http.Client])
void main() {
  // group('Testing API Restfo', () {
  //   test('should return restaurant correctly', () async {
  //     final client = MockClient((request) async {
  //       final response = {
  //         "error": false,
  //         "message": "success",
  //         "count": 20,
  //         "restaurants": []
  //       };
  //       return http.Response(json.encode(response), 200);
  //     });

  //     final apiService = Api(httpClient: client);
  //     final result = await apiService.fetchRestaurants();

  //     expect(result, isA<RestaurantResult>());
  //   });
  // });
  group("Testing Widget", () {
    testWidgets('SettingPage should have a Scaffold',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => SharedPrefProvider(
                  preferencesHelper: PreferencesHelper(
                    sharedPreference: SharedPreferences.getInstance(),
                  ),
                ),
              ),
              ChangeNotifierProvider(create: (context) => SchedulingProvider()),
            ],
            child: const SettingPage(),
          ),
        ),
      );

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(2));
    });
  });
}
