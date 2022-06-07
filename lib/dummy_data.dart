// ignore_for_file: non_constant_identifier_names

import 'package:weave_marketplace/models/item_model.dart';

List<Item> DUMMY_DATA = [
  Item(
      uid: 'item1',
      name: 'Nike Air Max 95',
      category: ['Shoes'],
      price: 230,
      images: [
        'assets/dummy_data/s1.png',
        'assets/dummy_data/s5.png',
        'assets/dummy_data/s7.png',
      ],
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Odio diam enim diam ut. Eu elit enim enim ultricies eu donec. Magnis urna aliquet ultricies.'),
  Item(
    uid: 'item2',
    name: 'Nike Air Max 97',
    category: ['Shoes'],
    price: 250,
    images: [
      'assets/dummy_data/s2.png',
    ],
  ),
  Item(
    uid: 'item3',
    name: 'Nike Air Max 200',
    category: ['Shoes'],
    price: 235,
    images: [
      'assets/dummy_data/s3.png',
    ],
  ),
  Item(
    uid: 'item4',
    name: 'Nike Air Max 260',
    category: ['Shoes'],
    price: 205,
    images: [
      'assets/dummy_data/s4.png',
    ],
  ),
];

List<String> CATEGORIES = [
  'Electricity',
  'Clothes',
  'Shoes',
  'Cars',
  'Mobile',
];
