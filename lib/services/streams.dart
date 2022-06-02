import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weave_marketplace/models/user_model.dart';
import 'package:weave_marketplace/state_managment/user_state.dart';

class DBStreams {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<UserState> getCurrentUser(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((doc) => UserState(UserModel.fromDocumentSnapshot(doc)));
  }
}
