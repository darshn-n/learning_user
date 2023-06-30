import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gsss_learning/screens/account_screen.dart';
import 'package:gsss_learning/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:gsss_learning/screens/subjects_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String id = "main-screen";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> iconNames = ["News", "Subjects", "Account"];
  List<IconData> icons = [
    Icons.home,
    Icons.subject_outlined,
    Icons.person,
  ];
  int _selectedIndex = 0;
  final screens = [
    const HomeScreen(),
    const SubjectsScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Theme.of(context).primaryColor,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: icons[0],
                  text: iconNames[0],
                ),
                GButton(
                  icon: icons[1],
                  text: iconNames[1],
                ),
                GButton(
                  icon: icons[2],
                  text: iconNames[2],
                ),
                
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
