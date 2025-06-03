import 'package:flutter/material.dart';
import 'package:restaurant_app/Views/app_main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure that plugin services are initialized before running the app.
  // This is important for plugins that rely on platform channels.
  // For example, if you are using plugins that access device features like
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}


