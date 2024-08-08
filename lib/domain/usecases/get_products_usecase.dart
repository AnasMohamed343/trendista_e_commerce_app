import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/entities/Category.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/domain/repository/products_repository.dart';

@injectable
class GetProductsUseCase {
  ProductRepository productRepository;
  @factoryMethod
  GetProductsUseCase({required this.productRepository});
  Future<List<Product>?> invoke([Category? category]) {
    // [] => optional and not named
    return productRepository.getProducts(categoryId: category?.id ?? '');
  }
}
