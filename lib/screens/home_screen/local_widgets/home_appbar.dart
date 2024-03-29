// ignore_for_file: prefer_const_constructors

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weave_marketplace/colors.dart';
import 'package:weave_marketplace/screens/cart_screen/cart_screen.dart';
import 'package:weave_marketplace/screens/upload_item_screen/upload_item_screen.dart';
import 'package:weave_marketplace/state_managment/basket_state.dart';
import 'package:weave_marketplace/state_managment/marketplace_state.dart';
import 'package:weave_marketplace/state_managment/user_state.dart';

class HomeAppbar extends StatelessWidget {
  final double? height;
  final Function? openSearchBar;

  const HomeAppbar({@required this.height, this.openSearchBar, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final marketState = Provider.of<MarketPlaceState>(context);
    final basketState = Provider.of<BasketState>(context);
    final userState = Provider.of<UserState>(context);

    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu),
            ),
            Spacer(),
            Badge(
              badgeColor: MAIN_COLOR,
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
                      child: CartScreen(),
                    ),
                  ),
                ),
                icon: Icon(
                  Icons.shopping_cart_outlined,
                ),
              ),
            ),
            IconButton(
              onPressed: () => openSearchBar!(),
              icon: Icon(
                Icons.search,
              ),
            ),
            IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider<UserState>.value(value: userState),
                      ChangeNotifierProvider<MarketPlaceState>.value(
                          value: marketState),
                    ],
                    child: UploadItemScreen(),
                  ),
                ),
              ),
              icon: Icon(
                Icons.add_business_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
