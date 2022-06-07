// ignore_for_file: unused_field, non_constant_identifier_names, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:weave_marketplace/models/item_model.dart';
import 'package:weave_marketplace/models/user_model.dart';

class ItemService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<Item>> getItems(String category) async {
    List<Item> items = [];

    try {
      final communitys = await _firestore.collection('communitys').get();
      for (var community in communitys.docs) {
        final allItems = community.reference.collection('marketplace');
        final categoryItems = category == 'All'
            ? await allItems.get()
            : await allItems.where('category', arrayContains: category).get();
        for (var item in categoryItems.docs) {
          items.add(Item.fromDocumentSnapshot(item));
        }
      }
    } catch (e) {
      print(e);
      rethrow;
    }

    return items;
  }

  Future<String> upload_item({
    UserModel? user,
    String? name,
    String? description,
    double? price,
    List<String>? category,
    List<File>? images,
  }) async {
    String retVal = 'error';
    try {
      final itemDoc = await _firestore
          .collection('communitys')
          .doc(user!.communityId)
          .collection('marketplace')
          .add({
        'name': name,
        'description': description,
        'price': price,
        'category': category,
        'ownerId': user.uid,
        'createdAt': Timestamp.now(),
      });
      await _upload_images(images, user.communityId, itemDoc.id);
      retVal = 'success';
    } catch (e) {
      print(e);
      rethrow;
    }
    return retVal;
  }

  Future<String> _upload_images(
    List<File>? images,
    String? communityId,
    String? itemId,
  ) async {
    String retVal = 'error';
    final ref = storage.ref().child('shop').child(communityId!).child(itemId!);
    try {
      List<String> imagesUrl = [];
      for (File image in images!) {
        final res = await ref.child(image.path.split('/').last).putFile(image);
        final url = await res.ref.getDownloadURL();
        imagesUrl.add(url);
      }
      await _firestore
          .collection('communitys')
          .doc(communityId)
          .collection('marketplace')
          .doc(itemId)
          .update(({
            'images': imagesUrl,
          }));
      retVal = 'success';
    } catch (e) {
      print(e);
      rethrow;
    }
    return retVal;
  }

  Future<String> toggleFavorite(
      String? uid, String? itemId, List<String> favorites) async {
    String retVal = 'error';
    try {
      favorites.contains(itemId)
          ? favorites.remove(itemId)
          : favorites.add(itemId!);

      await _firestore
          .collection('users')
          .doc(uid)
          .update({'favorites': favorites});

      retVal = 'success';
    } catch (e) {
      print(e);
      rethrow;
    }
    return retVal;
  }
}
