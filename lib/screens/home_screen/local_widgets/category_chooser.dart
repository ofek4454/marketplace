// ignore_for_file: non_constant_identifier_names, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weave_marketplace/state_managment/marketplace_state.dart';

class CategoryChooser extends StatelessWidget {
  Widget _build_category_item(BuildContext context, int index) {
    final storeState = Provider.of<MarketPlaceState>(context, listen: false);
    bool current = index == storeState.current;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: () => storeState.change_category(index),
        child: Container(
          padding: const EdgeInsets.only(bottom: 3),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2,
                color: current ? Colors.amber : Colors.transparent,
              ),
            ),
          ),
          child: Text(
            storeState.categories![index].name!,
            style: TextStyle(
              color: current ? Colors.amber : Colors.grey,
              fontSize: 16,
              fontFamily: 'Lato',
              fontWeight: current ? FontWeight.bold : FontWeight.w200,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final storeState = Provider.of<MarketPlaceState>(context);

    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.06,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: storeState.categories!.length,
        itemBuilder: ((context, index) => _build_category_item(context, index)),
      ),
    );
  }
}
