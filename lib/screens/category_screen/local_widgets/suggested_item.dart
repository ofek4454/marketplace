import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weave_marketplace/colors.dart';
import 'package:weave_marketplace/screens/item_screen/item_screen.dart';
import 'package:weave_marketplace/state_managment/basket_state.dart';
import 'package:weave_marketplace/state_managment/item_state.dart';

class SuggestedItemCard extends StatelessWidget {
  const SuggestedItemCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final itemState = Provider.of<ItemState>(context);
    final basketState = Provider.of<BasketState>(context, listen: false);

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<ItemState>.value(
            value: itemState,
            child: ItemScreen(heroTag: '${itemState.item!.uid}suggested'),
          ),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        //elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: size.width * 0.6,
          child: Stack(
            alignment: Alignment.center,
            // overflow: Overflow.visible,
            children: [
              Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: '${itemState.item!.uid}suggested',
                    child: Image.asset(
                      itemState.item!.images![0],
                    ),
                  ),
                  Text(
                    itemState.item!.name!,
                    style: const TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
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
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  onPressed: () => itemState.toggle_favorite(),
                  color: itemState.is_fav ? MAIN_COLOR : Colors.grey,
                  iconSize: 30,
                  icon: Icon(
                    itemState.is_fav ? Icons.favorite : Icons.favorite_border,
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
