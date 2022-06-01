// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weave_marketplace/models/category_model.dart';
import 'package:weave_marketplace/screens/category_screen/category_screen.dart';
import 'package:weave_marketplace/state_managment/category_state.dart';
import 'package:weave_marketplace/state_managment/store_state.dart';
import './local_widgets/home_appbar.dart';
import 'local_widgets/category_chooser.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final storeState = Provider.of<StoreState>(context);

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
                  child: ChangeNotifierProxyProvider<StoreState, CategoryState>(
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
