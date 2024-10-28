import 'package:trendista_e_commerce/domain/entities/Product.dart';

abstract class CartDataSource {
  Future<List<Product>?> getCart();

  Future getTotalPrice();

  Future<void> addOrRemoveCart(String productId);

  Future updateCartQuantity(String productId);
}
