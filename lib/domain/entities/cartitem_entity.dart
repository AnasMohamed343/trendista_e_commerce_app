import 'package:trendista_e_commerce/domain/entities/Product.dart';

class CartItemEntity {
  CartItemEntity({
    this.id,
    this.quantity,
    this.product,
  });

  CartItemEntity.fromJson(dynamic json) {
    id = json['id'].toInt();
    quantity = json['quantity'] != null ? json['quantity'].toInt() : 0;
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
  int? id;
  int? quantity;
  Product? product;
  CartItemEntity copyWith({
    int? id,
    int? quantity,
    Product? product,
  }) =>
      CartItemEntity(
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        product: product ?? this.product,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['quantity'] = quantity;
    if (product != null) {
      map['product'] = product?.toJson();
    }
    return map;
  }
}
