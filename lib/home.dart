import 'package:college_updates/screens/explore.dart';
import 'package:college_updates/other.dart';
import 'package:college_updates/screens/profile.dart';

import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String id;
  const HomePage({required this.id, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    pages = [
      const OtherExamplePage(),
      const ExplorePage(),
      const OtherExamplePage(),
      const OtherExamplePage(),
      ProfilePage(id: widget.id),
    ];
    super.initState();
  }

  List<Widget> pages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        iconSize: 22,
        animationDuration: const Duration(milliseconds: 500),
        items: [
          FlashyTabBarItem(
            activeColor: const Color(0xFFC683E5),
            inactiveColor: const Color.fromARGB(255, 188, 157, 203),
            icon: const Icon(Icons.home),
            title: const Text('Home'),
          ),
          FlashyTabBarItem(
            activeColor: const Color(0xFFC683E5),
            inactiveColor: const Color.fromARGB(255, 205, 184, 215),
            icon: const Icon(Icons.explore_outlined),
            title: const Text('Explore'),
          ),
          FlashyTabBarItem(
            activeColor: const Color(0xFFC683E5),
            inactiveColor: const Color.fromARGB(255, 205, 184, 215),
            icon: const Icon(Icons.add_circle_outline),
            title: const Text('Post'),
          ),
          FlashyTabBarItem(
            activeColor: const Color(0xFFC683E5),
            inactiveColor: const Color.fromARGB(255, 205, 184, 215),
            icon: const Icon(Icons.video_library_outlined),
            title: const Text('Videos'),
          ),
          FlashyTabBarItem(
            activeColor: const Color(0xFFC683E5),
            inactiveColor: const Color.fromARGB(255, 205, 184, 215),
            icon: const Icon(Icons.person_outline),
            title: const Text('Profile'),
          ),
        ],
      ),
      body: pages[_selectedIndex],
    );
  }
}
