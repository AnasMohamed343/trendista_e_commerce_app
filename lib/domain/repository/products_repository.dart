// import 'package:trendista_e_commerce/domain/entities/FavoriteProduct.dart';
//
// abstract class ProductRepository {
//   Future<List<Product>?> getProducts({ProductSort? sortBy, String? categoryId});
// }
//
// enum ProductSort {
//   mostSelling("-sold"),
//   highestPrice("-price");
//
//   final String value;
//   const ProductSort(this.value);
// }

import 'package:trendista_e_commerce/domain/entities/Product.dart';

abstract class ProductRepository {
  Future<List<Product>?> getProducts({ProductSort? sortBy, int? categoryId});
}

enum ProductSort {
  mostSelling("-sold"),
  highestPrice("-price");

  final String value;
  const ProductSort(this.value);
}
