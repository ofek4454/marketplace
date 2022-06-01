import 'package:flutter/material.dart';
import 'package:weave_marketplace/models/basket_item.dart';
import 'package:weave_marketplace/models/item_model.dart';

class BasketState extends ChangeNotifier {
  List<BasketItem>? _items;

  BasketState() : _items = [];

  List<BasketItem>? get items => _items;

  int get basket_quantity {
    int quantity = 0;
    items!.forEach((b_item) => quantity += b_item.quantity!);
    return quantity;
  }

  double get basket_price {
    double price = 0;
    items!
        .forEach((b_item) => price += (b_item.item!.price! * b_item.quantity!));
    return price;
  }

  Future<void> add_to_basket(Item item) async {
    int i = _items!.indexWhere((b_item) => b_item.item!.uid == item.uid);
    if (i == -1) {
      _items!.add(BasketItem(
        item: item,
        quantity: 1,
      ));
    } else {
      _items![i].quantity = _items![i].quantity! + 1;
    }
    notifyListeners();
  }

  Future<void> increase_quantity(Item item) async {
    int i = _items!.indexWhere((b_item) => b_item.item!.uid == item.uid);
    _items![i].quantity = _items![i].quantity! + 1;
    notifyListeners();
  }

  Future<void> decrease_quantity(Item item) async {
    int i = _items!.indexWhere((b_item) => b_item.item!.uid == item.uid);
    if (_items![i].quantity! > 1)
      _items![i].quantity = _items![i].quantity! - 1;
    notifyListeners();
  }

  Future<void> remove_from_busket(Item item) async {
    _items!.removeWhere((b_item) => b_item.item!.uid == item.uid);
    notifyListeners();
  }
}
