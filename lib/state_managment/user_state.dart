import 'package:flutter/material.dart';
import 'package:weave_marketplace/models/item_model.dart';
import 'package:weave_marketplace/models/user.dart';

class UserState extends ChangeNotifier {
  User? _user;

  UserState() : _user = User(name: 'ofek gorgi', uid: '123456', favorites: []);

  User? get user => _user;

  Future<void> upload_item(Item item) async {}
}
