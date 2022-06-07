import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weave_marketplace/colors.dart';
import 'package:weave_marketplace/screens/item_screen/item_screen.dart';
import 'package:weave_marketplace/state_managment/basket_state.dart';
import 'package:weave_marketplace/state_managment/item_state.dart';
import 'package:weave_marketplace/state_managment/user_state.dart';
import 'package:weave_marketplace/widgets/image_from_network.dart';

class SuggestedItemCard extends StatelessWidget {
  const SuggestedItemCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final itemState = Provider.of<ItemState>(context);
    final basketState = Provider.of<BasketState>(context, listen: false);
    final userState = Provider.of<UserState>(context);

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider<ItemState>.value(value: itemState),
              ChangeNotifierProvider<UserState>.value(value: userState),
              ChangeNotifierProvider<BasketState>.value(value: basketState),
            ],
            child: ItemScreen(heroTag: '${itemState.item!.uid}suggested'),
          ),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          width: size.width * 0.6,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                      tag: '${itemState.item!.uid}suggested',
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20)),
                        child: ImageFromNetwork(
                          itemState.item!.images!.first,
                          width: double.infinity,
                          height: size.height * 0.27,
                        ),
                      )),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      itemState.item!.name!,
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: RichText(
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
                  ),
                  const Spacer(),
                ],
              ),
              Positioned(
                top: 10,
                left: 10,
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
                bottom: 10,
                right: 10,
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
      ),
    );
  }
}
