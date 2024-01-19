import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreference;

  PreferencesHelper({required this.sharedPreference});

  static const dailyRestaurantSchedule = 'DAILY_SCHEDULE_RESTAURANT_APP';

  Future<bool> get isDailyRestaurantActive async {
    final prefs = await sharedPreference;
    return prefs.getBool(dailyRestaurantSchedule) ?? false;
  }

  void setDailyRestaurant(bool value) async {
    final prefs = await sharedPreference;
    prefs.setBool(dailyRestaurantSchedule, value);
  }
}
