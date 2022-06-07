import 'package:flutter/material.dart';
import 'package:weave_marketplace/models/user_model.dart';
import 'package:weave_marketplace/services/item_service.dart';

class UserState extends ChangeNotifier {
  final UserModel? _user;

  UserState(this._user);

  UserModel? get user => _user;

  bool isItemFav(String itemId) => _user!.favorites!.contains(itemId);

  Future<void> addToRecents(String itemId) async {
    if (_user!.recents!.contains(itemId)) _user!.recents!.remove(itemId);
    _user!.recents!.insert(0, itemId);
    if (_user!.recents!.length > 15) _user!.recents!.removeAt(15);

    ItemService().addToRecents(_user!.uid, user!.recents!);
    notifyListeners();
  }
}
