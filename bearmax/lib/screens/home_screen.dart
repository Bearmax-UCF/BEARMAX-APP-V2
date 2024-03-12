import 'package:bearmax/screens/interact_screen.dart';
import 'package:bearmax/screens/notes_screen.dart';
import 'package:bearmax/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:bearmax/util/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePage extends StatelessWidget {
  
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  HomePage({super.key});

  List<Widget> _buildScreens() {
    return [
      const NotesScreen(),
      const InteractScreen(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.notes),
        title: 'Notes',
        activeColorPrimary: Palette.accentColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.favorite),
        title: 'Interact',
        activeColorPrimary: Palette.accentColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.account_circle_rounded),
        title: 'Profile',
        activeColorPrimary: Palette.accentColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Palette.backgroundColor,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarStyle: NavBarStyle.style3, // Choose the desired style
    );
  }
}