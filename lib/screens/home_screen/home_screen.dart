// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weave_marketplace/models/category_model.dart';
import 'package:weave_marketplace/screens/category_screen/category_screen.dart';
import 'package:weave_marketplace/screens/home_screen/local_widgets/search_bar.dart';
import 'package:weave_marketplace/state_managment/category_state.dart';
import 'package:weave_marketplace/state_managment/marketplace_state.dart';
import './local_widgets/home_appbar.dart';
import 'local_widgets/category_chooser.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool isSearchOpen = false;
  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 800,
      ),
    );
    // אתחול אנימצית ההיעלמות בצורה של כניסה איטית והאצה
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _animationController!, curve: Curves.fastOutSlowIn));
    // אתחול אנימצית הגלילה בצורה של כניסה איטית והאצה
    _slideAnimation = Tween<Offset>(begin: Offset(0, -1.5), end: Offset(0, 0))
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.fastOutSlowIn));
  }

  void _open_search_bar() {
    if (!isSearchOpen) {
      setState(() {
        isSearchOpen = true;
      });
      _animationController!.forward();
    } else {
      setState(() {
        isSearchOpen = false;
      });
      _animationController!.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final storeState = Provider.of<MarketPlaceState>(context);

    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        color: const Color(0x0F5F5F50),
      ),
      child: !storeState.hasData
          ? Center(child: CircularProgressIndicator.adaptive())
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HomeAppbar(
                  height: size.height * 0.11,
                  openSearchBar: _open_search_bar,
                ),
                AnimatedContainer(
                  duration: Duration(
                    milliseconds: 1000,
                  ),
                  curve: Curves.fastOutSlowIn,
                  constraints: BoxConstraints(
                      minHeight: isSearchOpen ? 60 : 0,
                      maxHeight: isSearchOpen ? 120 : 0),
                  child: FadeTransition(
                    opacity: _fadeAnimation!,
                    child: SlideTransition(
                      position: _slideAnimation!,
                      child: Container(
                        margin:
                            EdgeInsets.only(left: 20, right: 20, bottom: 15),
                        child: SearchBar(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CategoryChooser(),
                Expanded(
                  child: ChangeNotifierProxyProvider<MarketPlaceState,
                      CategoryState>(
                    create: (context) => CategoryState(Category(name: 'All')),
                    update: (context, store, category) =>
                        CategoryState(store.category),
                    child: CategoryScreen(),
                  ),
                ),
              ],
            ),
    );
  }
}
