import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? communityId;
  List<String>? favorites;
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
    favorites =
        doc['favorites'] != null ? List<String>.from(doc['favorites']) : [];
  }
}
