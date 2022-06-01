import 'package:flutter/material.dart';
import 'package:weave_marketplace/models/category_model.dart';
import 'package:weave_marketplace/models/item_model.dart';

import '../dummy_data.dart';

class CategoryState extends ChangeNotifier {
  Category? _category;
  List<Item>? _items;

  CategoryState(this._category) {
    _items = null;
    _fetch_items();
  }

  Category? get category => _category;

  List<Item>? get items => _items;

  bool get hasData => _category != null && _items != null;

  Future<void> _fetch_items() async {
    //await Future.delayed(Duration(seconds: 2));

    _items = [];
    _items = _category!.name == 'All'
        ? DUMMY_DATA
        : DUMMY_DATA.where((item) => item.category == category!.name).toList();

    notifyListeners();
  }
}
