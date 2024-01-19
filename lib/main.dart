import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';
import 'package:restaurant_app/page/restaurant_detail_screen.dart';
import 'package:restaurant_app/page/restaurant_list_screen.dart';
import 'package:restaurant_app/page/restaurant_search_screen.dart';
import 'package:restaurant_app/page/splash_screen.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/schedulling_provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  await AndroidAlarmManager.initialize();

  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => RestaurantProvider(api: Api())),
        ChangeNotifierProvider(create: (context) => DetailProvider(api: Api())),
        ChangeNotifierProvider(create: (context) => SearchProvider(api: Api())),
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (context) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SharedPrefProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreference: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
        initialRoute: "/",
        navigatorKey: navigatorKey,
        routes: {
          '/': (context) => const SplashScreen(),
          '/restaurant-list': (context) => const RestaurantListPage(),
          '/restaurant-detail': (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments;

            if (arguments is Map<String, dynamic>) {
              return RestaurantDetailPage(
                restaurant: arguments['restaurant'] as Restaurant,
              );
            } else {
              return const Scaffold(
                body: Center(
                  child:
                      Text('Invalid arguments type for RestaurantDetailPage'),
                ),
              );
            }
          },
          '/restaurant-search': (context) => const RestaurantSearch()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
