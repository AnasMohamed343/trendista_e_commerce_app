import 'package:trendista_e_commerce/domain/entities/Product.dart';

abstract class CartRepository {
  Future<List<Product>?> getCart();

  Future getTotalPrice();

  Future<void> addOrRemoveCart(String productId);

  Future updateCartQuantity(String productId);
}
