import 'package:flutter/material.dart';
import 'package:tourism_app/screens/screen_app/favorite_screen.dart';
import 'package:tourism_app/screens/screen_app/screen_one.dart';

class TabScreens extends StatefulWidget {
  const TabScreens({super.key});
  @override
  State<TabScreens> createState() => _TabScreensState();
}

class _TabScreensState extends State<TabScreens> {
  int currentIndex = 0;
  List<Widget> screensList = [ScreenOne(), FavoriteScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
              color: currentIndex == 0 ? Colors.tealAccent : Colors.white,
            ),
            label: "التصنيفات",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: currentIndex == 1 ? Colors.pinkAccent : Colors.white,
            ),
            label: "المفضلة",
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.teal,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: screensList[currentIndex],
    );
  }
}
