import 'package:trendista_e_commerce/domain/entities/Product.dart';

class FavoriteProduct {
  FavoriteProduct({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
  });

  FavoriteProduct.fromJson(dynamic json) {
    id = json['id'].toInt();
    price = json['price'].toInt();
    oldPrice = json['old_price'].toInt();
    discount = json['discount'].toInt();
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  FavoriteProduct copyWith({
    int? id,
    int? price,
    int? oldPrice,
    int? discount,
    String? image,
    String? name,
    String? description,
  }) =>
      FavoriteProduct(
        id: id ?? this.id,
        price: price ?? this.price,
        oldPrice: oldPrice ?? this.oldPrice,
        discount: discount ?? this.discount,
        image: image ?? this.image,
        name: name ?? this.name,
        description: description ?? this.description,
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
    );
  }
}
