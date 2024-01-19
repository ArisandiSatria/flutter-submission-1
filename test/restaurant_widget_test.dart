import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';
import 'package:restaurant_app/page/setting_screen.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/schedulling_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
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
