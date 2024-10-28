import 'package:trendista_e_commerce/domain/entities/Product.dart';

class ProductDetailsDto {
  ProductDetailsDto({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
    this.inFavorites,
    this.inCart,
    this.images,
  });

  ProductDetailsDto.fromJson(dynamic json) {
    id = json['id'].toInt();
    price = json['price']?.toInt();
    oldPrice = json['old_price']?.toInt();
    discount = json['discount']?.toInt();
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
  }
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;
  List<String>? images;
  ProductDetailsDto copyWith({
    int? id,
    int? price,
    int? oldPrice,
    int? discount,
    String? image,
    String? name,
    String? description,
    bool? inFavorites,
    bool? inCart,
    List<String>? images,
  }) =>
      ProductDetailsDto(
        id: id ?? this.id,
        price: price ?? this.price,
        oldPrice: oldPrice ?? this.oldPrice,
        discount: discount ?? this.discount,
        image: image ?? this.image,
        name: name ?? this.name,
        description: description ?? this.description,
        inFavorites: inFavorites ?? this.inFavorites,
        inCart: inCart ?? this.inCart,
        images: images ?? this.images,
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
    map['in_favorites'] = inFavorites;
    map['in_cart'] = inCart;
    map['images'] = images;
    return map;
  }

  Product toProduct() {
    return Product(
        id: id,
        price: price,
        oldPrice: oldPrice,
        discount: discount,
        image: image,
        name: name,
        description: description,
        inFavorites: inFavorites,
        inCart: inCart,
        images: images);
  }
}
