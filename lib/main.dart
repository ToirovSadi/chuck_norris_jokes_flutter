import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import './screens/home_screen.dart';
import './screens/categories_screen.dart';
import './screens/joke_view_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chuck Norris Jokes',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/categories': (context) => const CategoriesScreen(),
        '/joke_view': (context) => const JokeViewScreen(),
      },
    );
  }
}
