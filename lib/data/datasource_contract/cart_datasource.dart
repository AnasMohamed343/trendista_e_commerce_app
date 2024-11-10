import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/domain/entities/cartitem_entity.dart';

abstract class CartDataSource {
  //Future<List<Product>?> getCart();

  Future<List<CartItemEntity>?> getCart();

  Future getTotalPrice();

  Future<void> addOrRemoveCart(String productId);

  Future updateCartQuantity(int cartItemId, String quantity);
}
