import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/page/restaurant_list_screen.dart';
import 'package:restaurant_app/page/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
      initialRoute: "/",
      routes: {
        '/': (context) => const SplashScreen(),
        '/restaurant-list': (context) => const RestaurantListPage(),
        // '/restaurant-detail': (context) => const RestaurantDetailPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
