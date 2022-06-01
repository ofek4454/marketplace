class Item {
  String? uid;
  String? name;
  String? description;
  String? category;
  List<String>? images;
  double? price;
  bool? isLiked;
  String? ownerId;
  String? comunnityId;

  Item({
    this.uid,
    this.name,
    this.description = '',
    this.category,
    this.images,
    this.price,
    this.isLiked,
    this.ownerId,
    this.comunnityId,
  });
}
