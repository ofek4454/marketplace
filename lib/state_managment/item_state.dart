// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:weave_marketplace/models/item_model.dart';
import 'package:weave_marketplace/services/item_service.dart';

class ItemState extends ChangeNotifier {
  final Item? _item;

  ItemState(this._item);

  Item? get item => _item;

  Future<void> toggle_favorite(String uid, List<String> favorites) async {
    await ItemService().toggleFavorite(uid, item!.uid, favorites);
    notifyListeners();
  }
}
