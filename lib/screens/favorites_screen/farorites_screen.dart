// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weave_marketplace/screens/cart_screen/cart_screen.dart';
import 'package:weave_marketplace/state_managment/basket_state.dart';
import 'package:weave_marketplace/state_managment/store_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final basketState = Provider.of<BasketState>(context);
    final storeState = Provider.of<StoreState>(context);

    final size = MediaQuery.of(context).size;

    return Container(
      color: const Color(0x0F5F5F50),
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Favorites',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Badge(
                  badgeColor: Colors.amber,
                  padding: const EdgeInsets.all(7),
                  badgeContent: Text(
                    '${basketState.basket_quantity}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider<BasketState>.value(
                          value: basketState,
                          child: const CartScreen(),
                        ),
                      ),
                    ),
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(thickness: 1),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: ,
          //     itemBuilder: (context, index) {},
          //   ),
          // ),
        ],
      ),
    );
  }
}
