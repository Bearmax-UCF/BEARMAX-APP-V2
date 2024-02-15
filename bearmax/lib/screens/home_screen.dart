import 'package:bearmax/screens/interact_screen.dart';
import 'package:bearmax/screens/profile_screen.dart';
import 'package:bearmax/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:bearmax/util/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final screens = [
    const ProfileScreen(),
    const InteractScreen(),
    const SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(()=> currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Interact',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Pallete.accentColor,
        backgroundColor: Pallete.backgroundColor,
        showUnselectedLabels: true,
        iconSize: 30,
      ),
    );
  }
}