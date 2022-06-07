// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:weave_marketplace/models/category_model.dart';
import 'package:weave_marketplace/models/item_model.dart';
import 'package:weave_marketplace/services/item_service.dart';

class CategoryState extends ChangeNotifier {
  final Category? _category;
  List<Item>? _items;
  bool isLoading = false;

  CategoryState(this._category) {
    isLoading = true;
    _items = null;
    _fetch_items();
  }

  Category? get category => _category;

  List<Item>? get items => _items;

  bool get hasData => _category != null && _items != null;

  Future<void> _fetch_items() async {
    _items = [];
    _items = await ItemService().getItems(_category!.name!);
    isLoading = false;
    notifyListeners();
  }

  List<Item> search(String key) {
    return _items!
        .where((item) =>
            item.name!.contains(key) || item.description!.contains(key))
        .toList();
  }
}
