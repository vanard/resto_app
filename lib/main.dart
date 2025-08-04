import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/restaurants_provider.dart';
import 'package:restaurant_app/screens/app_main_screen.dart';
import 'package:restaurant_app/theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RestaurantsProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme.copyWith(
        textTheme: GoogleFonts.senTextTheme(Theme.of(context).textTheme),
      ),
      darkTheme: darkTheme.copyWith(
        textTheme: GoogleFonts.senTextTheme(Theme.of(context).textTheme),
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}
