// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weave_marketplace/colors.dart';
import 'package:weave_marketplace/models/basket_item.dart';
import 'package:weave_marketplace/state_managment/basket_state.dart';

class CartItem extends StatelessWidget {
  final BasketItem item;
  const CartItem(this.item, {Key? key}) : super(key: key);

  Widget _build_btn(IconData icon, Function action) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: MAIN_COLOR,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: () {
          HapticFeedback.lightImpact();
          action(item.item);
        },
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(color: MAIN_COLOR),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Icon(
            icon,
            size: 15,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final basketState = Provider.of<BasketState>(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(20)),
            child: Image.network(
              item.item!.images!.first,
              height: double.infinity,
              fit: BoxFit.cover,
              width: size.width * 0.25,
            ),
          ),
          const SizedBox(width: 35),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.item!.name!,
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
                      text: '${item.item!.price}',
                      style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _build_btn(
                    Icons.add,
                    basketState.increase_quantity,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '${item.quantity}',
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  _build_btn(
                    Icons.remove,
                    basketState.decrease_quantity,
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              splashColor: MAIN_COLOR,
              onPressed: () async {
                HapticFeedback.mediumImpact();
                bool? res = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Are you sure?'),
                    content: const Text('This action canot be canceled'),
                    actions: [
                      TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) => MAIN_COLOR.withAlpha(100)),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: MAIN_COLOR),
                        child: const Text(
                          'Remove',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                );
                if (res!) basketState.remove_from_busket(item.item!);
              },
              color: MAIN_COLOR,
              icon: const Icon(
                Icons.delete_outline_rounded,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
