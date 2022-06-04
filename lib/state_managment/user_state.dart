import 'package:flutter/material.dart';
import 'package:weave_marketplace/models/user_model.dart';

class UserState extends ChangeNotifier {
  final UserModel? _user;

  UserState(this._user);

  UserModel? get user => _user;
}
