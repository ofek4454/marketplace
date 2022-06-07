import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? communityId;
  List<String>? favorites;
  List<String>? recents;
  Timestamp? createdAt;

  UserModel({
    this.name,
    this.uid,
    this.favorites,
    this.email,
    this.createdAt,
    this.communityId,
    this.recents,
  });

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    uid = doc.id;
    name = doc['name'];
    email = doc['email'];
    createdAt = doc['createdAt'];
    communityId = doc['communityId'];
    favorites = doc.data()!.containsKey('favorites')
        ? List<String>.from(doc['favorites'])
        : [];
    recents = doc.data()!.containsKey('recents')
        ? List<String>.from(doc['recents'])
        : [];
  }
}
