import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/domain/entities/cartitem_entity.dart';

import 'ProductCartItemDto.dart';

class CartItemsDto {
  CartItemsDto({
    this.id,
    this.quantity,
    this.product,
  });

  CartItemsDto.fromJson(dynamic json) {
    id = json['id'].toInt();
    quantity = json['quantity'] != null ? json['quantity'].toInt() : 0;
    product = json['product'] != null
        ? ProductCartItemDto.fromJson(json['product'])
        : null;
  }
  int? id;
  int? quantity;
  ProductCartItemDto? product;
  CartItemsDto copyWith({
    int? id,
    int? quantity,
    ProductCartItemDto? product,
  }) =>
      CartItemsDto(
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

  //Product toProduct() => product!.toProduct();
  CartItemEntity toCartItemEntity() => CartItemEntity(
        id: id,
        quantity: quantity,
        product: product?.toProduct(),
      );
}
