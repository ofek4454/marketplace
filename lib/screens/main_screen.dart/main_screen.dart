import 'package:flutter/material.dart';
import 'package:weave_marketplace/screens/favorites_screen/farorites_screen.dart';
import 'package:weave_marketplace/screens/home_screen/home_screen.dart';
import 'package:weave_marketplace/screens/main_screen.dart/local_widgets/bottom_nav.dart';
import 'package:weave_marketplace/screens/profile_screen/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _current_page = 0;

  void change_page(int page) {
    print("change page $page");
    setState(() {
      _current_page = page;
    });
  }

  Widget get_current_page() {
    switch (_current_page) {
      case 0: // home
        return HomeScreen();
      case 1: // likes
        return FavoritesScreen();
      case 2: // profile
        return ProfileScreen();
      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          color: Color(0x00F5F5F5),
        ),
        child: Column(
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 150),
                child: get_current_page(),
              ),
            ),
            BottomNav(
              current_page: _current_page,
              change_page: change_page,
            ),
          ],
        ),
      ),
    );
  }
}
