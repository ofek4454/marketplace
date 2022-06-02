import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weave_marketplace/screens/item_screen/item_screen.dart';
import 'package:weave_marketplace/state_managment/basket_state.dart';
import 'package:weave_marketplace/state_managment/item_state.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemState = Provider.of<ItemState>(context);
    final basketState = Provider.of<BasketState>(context, listen: false);

    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.2,
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider<ItemState>.value(
              value: itemState,
              child: ItemScreen(heroTag: '${itemState.item!.uid}'),
            ),
          ),
        ),
        child: Stack(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                    left: 10, right: 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: '${itemState.item!.uid}',
                      child: Image.asset(
                        itemState.item!.images!.last,
                        //height: size.width * 0.3,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () => itemState.toggle_favorite(),
                          color: itemState.is_fav ? Colors.amber : Colors.grey,
                          iconSize: 30,
                          icon: Icon(
                            itemState.is_fav
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                        ),
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
                                  color: Colors.amber,
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
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: IconButton(
                color: Colors.amber,
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
