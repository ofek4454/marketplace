import 'package:cloud_firestore/cloud_firestore.dart';

class MarketPlaceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getCategories() async {
    List<String> categories = [];

    final doc =
        await _firestore.collection('marketplace').doc('categories').get();

    categories = List<String>.from(doc['all']);
    categories.sort();
    categories.insert(0, 'All');

    return categories;
  }
}
