import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weave_marketplace/models/item_model.dart';
import 'package:weave_marketplace/models/user_model.dart';

class UserState extends ChangeNotifier {
  UserModel? _user;

  UserState(this._user);

  UserModel? get user => _user;

  Future<void> upload_item(Item item) async {}
}
