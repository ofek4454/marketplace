import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String? uid;
  String? name;
  String? description;
  List<String>? category;
  List<String>? images;
  double? price;
  String? ownerId;
  Timestamp? createdAt;

  Item({
    this.uid,
    this.name,
    this.description = '',
    this.category,
    this.images,
    this.price,
    this.ownerId,
    this.createdAt,
  });

  Item.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    uid = doc.id;
    name = doc['name'];
    description = doc['description'];
    price = doc['price'];
    category = List<String>.from(doc['category']);
    ownerId = doc['ownerId'];
    createdAt = doc['createdAt'];
    images = List<String>.from(doc['images']);
  }
}
