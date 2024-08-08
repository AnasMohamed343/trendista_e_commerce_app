import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/domain/repository/products_repository.dart';

abstract class ProductDataSource {
  Future<List<Product>?> getProducts({ProductSort? sortBy, String? categoryId});
}
