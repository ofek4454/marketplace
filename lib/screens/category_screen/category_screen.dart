// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weave_marketplace/colors.dart';
import 'package:weave_marketplace/models/item_model.dart';
import 'package:weave_marketplace/screens/category_screen/local_widgets/item_card.dart';
import 'package:weave_marketplace/screens/category_screen/local_widgets/suggested_item.dart';
import 'package:weave_marketplace/state_managment/category_state.dart';
import 'package:weave_marketplace/state_managment/item_state.dart';
import 'package:weave_marketplace/state_managment/user_state.dart';

class CategoryScreen extends StatelessWidget {
  final String? searchKey;
  const CategoryScreen(this.searchKey, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryState = Provider.of<CategoryState>(context);
    final userState = Provider.of<UserState>(context);

    final size = MediaQuery.of(context).size;

    List<Item>? items = searchKey == null
        ? categoryState.items
        : categoryState.search(searchKey!);

    List<Item>? recents = [];
    for (var recentItemId in userState.user!.recents!) {
      final index = items!.indexWhere((element) => element.uid == recentItemId);
      if (index != -1) recents.add(items.elementAt(index));
    }

    return !categoryState.hasData || categoryState.isLoading
        ? const Center(child: CircularProgressIndicator.adaptive())
        : items!.isEmpty
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
                    const SizedBox(height: 10),
                    _build_title('Recents'),
                    const SizedBox(height: 10),
                    if (recents.isNotEmpty)
                      SizedBox(
                        height: size.height * 0.4,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: recents.length,
                          itemBuilder: (context, index) =>
                              ChangeNotifierProvider<ItemState>(
                            create: (context) => ItemState(
                              recents[index],
                            ),
                            child: const SuggestedItemCard(),
                          ),
                        ),
                      ),
                    // rest of page
                    const SizedBox(height: 20),
                    _build_title('Popular', filter: false),
                    // all products
                    ...items.map(
                      (item) => ChangeNotifierProvider<ItemState>(
                        create: (context) => ItemState(item),
                        child: const ItemCard(),
                      ),
                    ),
                  ],
                ),
              );
  }

  Padding _build_title(String title, {bool filter = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Lato',
              fontSize: 20,
            ),
          ),
          if (filter)
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => MAIN_COLOR.withAlpha(50)),
              ),
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
