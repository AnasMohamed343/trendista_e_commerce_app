// import 'package:injectable/injectable.dart';
// import 'package:trendista_e_commerce/domain/entities/Category.dart';
// //import 'package:trendista_e_commerce/domain/entities/route_e-commerce/Category.dart';
// import 'package:trendista_e_commerce/domain/entities/route_e-commerce/FavoriteProduct.dart';
// import 'package:trendista_e_commerce/domain/repository/products_repository.dart';
//
// @injectable
// class GetProductsUseCase {
//   ProductRepository productRepository;
//   @factoryMethod
//   GetProductsUseCase({required this.productRepository});
//   Future<List<Product>?> invoke([Category? category]) {
//     // [] => optional and not named
//     return productRepository.getProducts(categoryId: category?.id);
//   }
// }
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/entities/Category.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
//import 'package:trendista_e_commerce/domain/entities/route_e-commerce/Category.dart';
import 'package:trendista_e_commerce/domain/repository/products_repository.dart';

@injectable
class GetProductsUseCase {
  ProductRepository productRepository;
  @factoryMethod
  GetProductsUseCase({required this.productRepository});
  // Future<List<Product>?> invoke([Category? category]) {
  //   // [] => optional and not named
  //   return productRepository.getProducts(categoryId: category?.id);
  // }
  Future<List<Product>?> invoke({int? categoryId}) async {
    return await productRepository.getProducts(categoryId: categoryId);
  }
  //
  // Future<List<Product>>invokeByCategory(Category category) async {
  //   final products = await productRepository.getProducts();
  //   return products.where((product) => product.categoryId == category.id).toList();
  // }
}
