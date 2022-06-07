import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weave_marketplace/colors.dart';
import 'package:weave_marketplace/screens/item_screen/item_screen.dart';
import 'package:weave_marketplace/state_managment/basket_state.dart';
import 'package:weave_marketplace/state_managment/item_state.dart';
import 'package:weave_marketplace/state_managment/user_state.dart';
import 'package:weave_marketplace/widgets/image_from_network.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemState = Provider.of<ItemState>(context);
    final basketState = Provider.of<BasketState>(context, listen: false);
    final userState = Provider.of<UserState>(context);

    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.2,
      child: GestureDetector(
        onTap: () {
          userState.addToRecents(itemState.item!.uid!);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider<ItemState>.value(value: itemState),
                  ChangeNotifierProvider<UserState>.value(value: userState),
                  ChangeNotifierProvider<BasketState>.value(value: basketState),
                ],
                child: ItemScreen(heroTag: '${itemState.item!.uid}'),
              ),
            ),
          );
        },
        child: Stack(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Hero(
                      tag: '${itemState.item!.uid}',
                      child: ClipRRect(
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(20)),
                        child: ImageFromNetwork(
                          itemState.item!.images!.first,
                          width: size.width * 0.3,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                itemState.item!.name!,
                                style: const TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 10),
                              RichText(
                                textAlign: TextAlign.start,
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
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: IconButton(
                onPressed: () => itemState.toggle_favorite(
                    userState.user!.uid!, userState.user!.favorites!),
                color: userState.isItemFav(itemState.item!.uid!)
                    ? MAIN_COLOR
                    : Colors.grey,
                iconSize: 30,
                icon: Icon(
                  userState.isItemFav(itemState.item!.uid!)
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: IconButton(
                color: MAIN_COLOR,
                onPressed: () {
                  basketState.add_to_basket(itemState.item!);
                  HapticFeedback.heavyImpact();
                },
                icon: const Icon(Icons.add_shopping_cart_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
