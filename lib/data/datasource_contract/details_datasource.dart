import 'package:trendista_e_commerce/domain/entities/Product.dart';

abstract class DetailsDataSource {
  Future<Product?> getProductDetails(int productId);
}
