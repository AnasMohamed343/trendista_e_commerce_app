import 'package:trendista_e_commerce/domain/entities/Product.dart';

import 'FavoriteProduct.dart';

class FavoriteProductDto {
  FavoriteProductDto({
    this.id,
    this.product,
  });

  FavoriteProductDto.fromJson(dynamic json) {
    id = json['id'].toInt();
    product = json['product'] != null
        ? FavoriteProduct.fromJson(json['product'])
        : null;
  }
  int? id;
  FavoriteProduct? product;
  FavoriteProductDto copyWith({
    int? id,
    FavoriteProduct? product,
  }) =>
      FavoriteProductDto(
        id: id ?? this.id,
        product: product ?? this.product,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (product != null) {
      map['product'] = product?.toJson();
    }
    return map;
  }

  Product toProduct() {
    return product!.toProduct();
  }
}
