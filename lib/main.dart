import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/page/restaurant_detail_screen.dart';
import 'package:restaurant_app/page/restaurant_list_screen.dart';
import 'package:restaurant_app/page/splash_screen.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

void main() {
  runApp(const MyApp(),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RestaurantProvider(api: Api())),
        ChangeNotifierProvider(create: (context) => DetailProvider(api: Api())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
        initialRoute: "/",
        routes: {
          '/': (context) => const SplashScreen(),
          '/restaurant-list': (context) => const RestaurantListPage(),
          '/restaurant-detail': (context) => RestaurantDetailPage(
             restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
          )
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
