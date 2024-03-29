// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:weave_marketplace/models/category_model.dart';
import 'package:weave_marketplace/services/marketplace.dart';

class MarketPlaceState extends ChangeNotifier {
  int? _current_category;
  List<Category>? _categories;

  MarketPlaceState() : _current_category = 0 {
    _categories = null;
    _fetch_categories();
  }

  List<Category>? get categories => _categories;
  Category get category => _categories![_current_category!];
  int get current => _current_category!;

  bool get hasData => _categories != null;

  Future<void> _fetch_categories() async {
    List<String> categories = await MarketPlaceService().getCategories();
    _categories = [];
    categories.forEach((element) {
      _categories!.add(Category(name: element));
    });
    notifyListeners();
  }

  void change_category(int new_category) {
    _current_category = new_category;
    notifyListeners();
  }
}
