import 'package:trendista_e_commerce/domain/entities/Product.dart';

class FavoriteProductDto {
  FavoriteProductDto({
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

  FavoriteProductDto.fromJson(dynamic json) {
    id = json['id'];
    price = json['price'].toInt();
    oldPrice = json['old_price'].toInt();
    discount = json['discount'].toInt();
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

  FavoriteProductDto copyWith({
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
      FavoriteProductDto(
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

  Product toProduct() {
    return Product(
      id: id,
      price: price,
      oldPrice: oldPrice,
      discount: discount,
      image: image,
      name: name,
      description: description,
      images: images,
      inFavorites: inFavorites,
      inCart: inCart,
    );
  }
}
