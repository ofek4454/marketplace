// ignore_for_file: unused_field, non_constant_identifier_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weave_marketplace/models/user_model.dart';

class ItemService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> upload_item(
    UserModel user,
    String? name,
    String? description,
    double? price,
    String? category,
  ) async {
    String retVal = 'error';
    final _firestore = FirebaseFirestore.instance;
    try {
      await _firestore
          .collection('communitys')
          .doc(user.communityId)
          .collection('store')
          .add({
        'name': name,
        'description': description,
        'price': price,
        'category': category,
        'ownerId': user.uid,
        'createdAt': Timestamp.now(),
      });
      retVal = 'success';
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}
