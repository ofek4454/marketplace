import 'package:weave_marketplace/models/item_model.dart';

class User {
  String? uid;
  String? name;
  List<Item>? favorites;
  User({this.name, this.uid, this.favorites});
}
