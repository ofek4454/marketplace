import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weave_marketplace/colors.dart';
import 'package:weave_marketplace/screens/cart_screen/cart_screen.dart';
import 'package:weave_marketplace/screens/item_screen/local_widgets/image_viewer.dart';
import 'package:weave_marketplace/state_managment/basket_state.dart';
import 'package:weave_marketplace/state_managment/item_state.dart';
import 'package:weave_marketplace/state_managment/user_state.dart';

class ItemScreen extends StatelessWidget {
  final String? heroTag;
  const ItemScreen({required this.heroTag, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final itemState = Provider.of<ItemState>(context);
    final userState = Provider.of<UserState>(context);

    String categoryText = '';
    for (var category in itemState.item!.category!) {
      categoryText += '$category , ';
    }
    if (itemState.item!.category!.isNotEmpty) {
      categoryText = categoryText.substring(0, categoryText.length - 2);
    }

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        ImageViewer(heroTag: heroTag),
                        _app_bar(itemState, userState),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            categoryText,
                            style: const TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                          // TODO: place to rating if needed
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            itemState.item!.name!,
                            style: const TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 28,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '\$ ',
                              style: const TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 18,
                                color: MAIN_COLOR,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${itemState.item!.price}',
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
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Description',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        itemState.item!.description!,
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 17,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.3,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Container(
          width: size.width * 0.2,
          height: size.width * 0.2,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
          child: RawMaterialButton(
            shape: const CircleBorder(),
            child: const Icon(
              Icons.shopping_basket_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              HapticFeedback.heavyImpact();
              final basketState =
                  Provider.of<BasketState>(context, listen: false);
              basketState.add_to_basket(itemState.item!);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  action: SnackBarAction(
                    label: 'View',
                    textColor: Colors.white,
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider<BasketState>.value(
                          value: basketState,
                          child: const CartScreen(),
                        ),
                      ),
                    ),
                  ),
                  backgroundColor: MAIN_COLOR,
                  content: const Text(
                    'Go to cart',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Container _app_bar(ItemState itemState, UserState userState) {
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
      // color: Colors.white24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white54,
            ),
            child: const BackButton(
              color: Colors.black,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white54,
            ),
            child: IconButton(
              onPressed: () => itemState.toggle_favorite(
                  userState.user!.uid!, userState.user!.favorites!),
              color: userState.isItemFav(itemState.item!.uid!)
                  ? MAIN_COLOR
                  : Colors.black,
              iconSize: 30,
              icon: Icon(
                userState.isItemFav(itemState.item!.uid!)
                    ? Icons.favorite
                    : Icons.favorite_border,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
