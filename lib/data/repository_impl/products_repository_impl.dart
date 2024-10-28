// import 'package:injectable/injectable.dart';
// import 'package:trendista_e_commerce/data/datasource_contract/product_datasource.dart';
// import 'package:trendista_e_commerce/domain/entities/FavoriteProduct.dart';
// import 'package:trendista_e_commerce/domain/repository/products_repository.dart';
//
// @Injectable(as: ProductRepository)
// class ProductRepositoryImpl extends ProductRepository {
//   ProductDataSource productDataSource;
//   @factoryMethod
//   ProductRepositoryImpl({required this.productDataSource});
//   @override
//   Future<List<Product>?> getProducts(
//       {ProductSort? sortBy, String? categoryId}) {
//     return productDataSource.getProducts(categoryId: categoryId ?? '');
//   }
// }

import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/datasource_contract/product_datasource.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/domain/repository/products_repository.dart';

@Injectable(as: ProductRepository)
class ProductRepositoryImpl extends ProductRepository {
  ProductDataSource productDataSource;
  @factoryMethod
  ProductRepositoryImpl({required this.productDataSource});
  @override
  Future<List<Product>?> getProducts({ProductSort? sortBy, int? categoryId}) {
    return productDataSource.getProducts(categoryId: categoryId);
  }
}
