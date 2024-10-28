// class Product {
//   Product({
//     this.id,
//     this.price,
//     this.oldPrice,
//     this.discount,
//     this.image,
//     this.name,
//     this.description,
//     this.images,
//     this.inFavorites,
//     this.inCart,
//   });
//
//   Product.fromJson(dynamic json) {
//     id = json['id'].toInt();
//     price = json['price'].toInt();
//     oldPrice = json['old_price'].toInt();
//     discount = json['discount'].toInt();
//     image = json['image'];
//     name = json['name'];
//     description = json['description'];
//     images = json['images'] != null ? json['images'].cast<String>() : [];
//     inFavorites = json['in_favorites'];
//     inCart = json['in_cart'];
//   }
//   int? id;
//   int? price;
//   int? oldPrice;
//   int? discount;
//   String? image;
//   String? name;
//   String? description;
//   List<String>? images;
//   bool? inFavorites;
//   bool? inCart;
//   Product copyWith({
//     int? id,
//     int? price,
//     int? oldPrice,
//     int? discount,
//     String? image,
//     String? name,
//     String? description,
//     List<String>? images,
//     bool? inFavorites,
//     bool? inCart,
//   }) =>
//       Product(
//         id: id ?? this.id,
//         price: price ?? this.price,
//         oldPrice: oldPrice ?? this.oldPrice,
//         discount: discount ?? this.discount,
//         image: image ?? this.image,
//         name: name ?? this.name,
//         description: description ?? this.description,
//         images: images ?? this.images,
//         inFavorites: inFavorites ?? this.inFavorites,
//         inCart: inCart ?? this.inCart,
//       );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['price'] = price;
//     map['old_price'] = oldPrice;
//     map['discount'] = discount;
//     map['image'] = image;
//     map['name'] = name;
//     map['description'] = description;
//     map['images'] = images;
//     map['in_favorites'] = inFavorites;
//     map['in_cart'] = inCart;
//     return map;
//   }
// }

class Product {
  Product({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
    this.images,
    this.inFavorites,
    this.inCart,
  });

  Product.fromJson(dynamic json) {
    id = json['id']?.toInt();

    // price = json['price'].toInt(); // Handle null
    // oldPrice = json['old_price'].toInt(); // Handle null
    // discount = json['discount'].toInt(); // Handle null
    price = json['price']?.toInt();
    oldPrice = json['old_price']?.toInt();
    discount = json['discount']?.toInt();

    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  Product copyWith({
    int? id,
    int? price,
    int? oldPrice,
    int? discount,
    String? image,
    String? name,
    String? description,
    List<String>? images,
    bool? inFavorites,
    bool? inCart,
  }) =>
      Product(
        id: id ?? this.id,
        price: price ?? this.price,
        oldPrice: oldPrice ?? this.oldPrice,
        discount: discount ?? this.discount,
        image: image ?? this.image,
        name: name ?? this.name,
        description: description ?? this.description,
        images: images ?? this.images,
        inFavorites: inFavorites ?? this.inFavorites,
        inCart: inCart ?? this.inCart,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['price'] = price;
    map['old_price'] = oldPrice;
    map['discount'] = discount;
    map['image'] = image;
    map['name'] = name;
    map['description'] = description;
    map['images'] = images;
    map['in_favorites'] = inFavorites;
    map['in_cart'] = inCart;
    return map;
  }
}
