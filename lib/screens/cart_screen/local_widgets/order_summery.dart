// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weave_marketplace/state_managment/basket_state.dart';

class OrderSummery extends StatelessWidget {
  const OrderSummery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final basketState = Provider.of<BasketState>(context);

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        //height: size.height * 0.4,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Order Summary',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 10),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Items quantity',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'pcs ',
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 18,
                        color: Colors.amber,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${basketState.basket_quantity}',
                          style: const TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '\$ ',
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 18,
                        color: Colors.amber,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${basketState.basket_price}',
                          style: const TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
