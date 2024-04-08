import 'package:bearmax/screens/interact_screen.dart';
import 'package:bearmax/screens/notes_screen.dart';
import 'package:bearmax/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:bearmax/util/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePage extends StatelessWidget {
  final int initialIndex; 

  const HomePage({Key? key, this.initialIndex = 0}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    final PersistentTabController controller =
        PersistentTabController(initialIndex: initialIndex);

    List<Widget> buildScreens() {
      return [
        const NotesScreen(),
        const InteractScreen(),
        const ProfileScreen(),
      ];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
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

    return PersistentTabView(
      context,
      controller: controller,
      screens: buildScreens(),
      items: navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Palette.backgroundColor,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarStyle: NavBarStyle.style3, 
    );
  }
}
