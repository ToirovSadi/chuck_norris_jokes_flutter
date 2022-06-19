import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';
import '../widgets/bottom_menu.dart';
import '../widgets/home.dart';
import '../widgets/favorites.dart';
import '../widgets/search.dart';
import '../widgets/screen_not_found.dart';

class HomeScreen extends StatefulWidget {
  static const screenName = '/';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // current Screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: _bodyScreen(_currentIndex),
      bottomNavigationBar: BottomMenu(
          currentIndex: _currentIndex,
          onChanged: (index) => setState(() => _currentIndex = index)),
    );
  }

  Widget _bodyScreen(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const Home();
      case 1:
        return const Search();
      case 2:
        return const Favorites();
    }
    return const ScreenNotFound();
  }
}
