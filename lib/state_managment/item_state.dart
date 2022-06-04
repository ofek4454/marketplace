// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:weave_marketplace/models/item_model.dart';

class ItemState extends ChangeNotifier {
  final Item? _item;

  ItemState(this._item);

  Item? get item => _item;
  bool get is_fav => _item!.isLiked!;

  Future<void> toggle_favorite() async {
    _item!.isLiked = !_item!.isLiked!;
    notifyListeners();
  }
}
