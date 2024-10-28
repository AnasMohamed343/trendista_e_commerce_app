import 'package:trendista_e_commerce/domain/entities/Product.dart';

abstract class DetailsRepository {
  Future<Product?> getProductDetails(int productId);
}
