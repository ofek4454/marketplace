// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weave_marketplace/colors.dart';
import 'package:weave_marketplace/screens/cart_screen/local_widgets/cart_item.dart';
import 'package:weave_marketplace/screens/cart_screen/local_widgets/order_summery.dart';
import 'package:weave_marketplace/state_managment/basket_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final basketState = Provider.of<BasketState>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w500,
          ),
          title: const Text('Shopping Cart'),
          leading: const BackButton(
            color: Colors.black,
          ),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            color: Color(0x00F5F5F5),
          ),
          child: basketState.basket_quantity == 0
              ? const Center(
                  child: Text('Cart is empty'),
                )
              : ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    ...basketState.items!.map((e) => CartItem(e)),
                    const SizedBox(height: 30),
                    const OrderSummery(),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: size.width * 0.85,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Checkout',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: MAIN_COLOR,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
