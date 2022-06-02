import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weave_marketplace/models/item_model.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? communityId;
  List<Item>? favorites;
  Timestamp? createdAt;

  UserModel({
    this.name,
    this.uid,
    this.favorites,
    this.email,
    this.createdAt,
    this.communityId,
  });

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    uid = doc.id;
    name = doc['name'];
    email = doc['email'];
    createdAt = doc['createdAt'];
    communityId = doc['communityId'];
  }
}
