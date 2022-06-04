// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:weave_marketplace/models/category_model.dart';

class StoreState extends ChangeNotifier {
  int? _current_category;
  List<Category>? _categories;

  StoreState() : _current_category = 0 {
    _categories = null;
    _fetch_categories();
  }

  List<Category>? get categories => _categories;
  Category get category => _categories![_current_category!];
  int get current => _current_category!;

  bool get hasData => _categories != null;

  Future<void> _fetch_categories() async {
    await Future.delayed(const Duration(seconds: 2));
    List<String> categories = ['All', 'Shoes', 'Clothes', 'Watchs'];
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
