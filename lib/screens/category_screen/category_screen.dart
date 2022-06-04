// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weave_marketplace/screens/category_screen/local_widgets/item_card.dart';
import 'package:weave_marketplace/screens/category_screen/local_widgets/suggested_item.dart';
import 'package:weave_marketplace/state_managment/category_state.dart';
import 'package:weave_marketplace/state_managment/item_state.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryState = Provider.of<CategoryState>(context);
    final size = MediaQuery.of(context).size;
    return !categoryState.hasData
        ? const Center(child: CircularProgressIndicator.adaptive())
        : categoryState.items!.isEmpty
            ? Center(
                child: Text(
                  'No items in category yet',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontFamily: 'Lato'),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // suggested
                    SizedBox(
                      height: size.height * 0.4,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryState.items!.length,
                        itemBuilder: (context, index) =>
                            ChangeNotifierProvider<ItemState>(
                          create: (context) =>
                              ItemState(categoryState.items![index]),
                          child: const SuggestedItemCard(),
                        ),
                      ),
                    ),
                    // rest of page
                    const SizedBox(height: 20),
                    _build_popular(),
                    // all products
                    ...categoryState.items!.map(
                      (item) => ChangeNotifierProvider<ItemState>(
                        create: (context) => ItemState(item),
                        child: const ItemCard(),
                      ),
                    ),
                  ],
                ),
              );
  }

  Padding _build_popular() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Popular',
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 20,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Show all',
              style: TextStyle(
                fontWeight: FontWeight.w200,
                fontFamily: 'Lato',
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
