// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weave_marketplace/screens/main_screen.dart/main_screen.dart';
import 'package:weave_marketplace/state_managment/basket_state.dart';
import 'package:weave_marketplace/state_managment/store_state.dart';
import 'package:weave_marketplace/state_managment/user_state.dart';

import 'screens/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StoreState>(
          create: (context) => StoreState(),
        ),
        ChangeNotifierProvider<BasketState>(
          create: (context) => BasketState(),
        ),
        ChangeNotifierProvider<UserState>(
          create: (context) => UserState(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weave',
        theme: ThemeData(
          canvasColor: Colors.white,
          primarySwatch: Colors.blue,
        ),
        home: SafeArea(
          child: const MainScreen(),
        ),
      ),
    );
  }
}
