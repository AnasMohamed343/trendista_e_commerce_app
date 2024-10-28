import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/datasource_contract/cart_datasource.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/domain/repository/cart_repository.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl extends CartRepository {
  CartDataSource cartDataSource;
  @factoryMethod
  CartRepositoryImpl({required this.cartDataSource});
  @override
  Future<List<Product>?> getCart() {
    return cartDataSource.getCart();
  }

  @override
  Future getTotalPrice() {
    return cartDataSource.getTotalPrice();
  }

  @override
  Future<void> addOrRemoveCart(String productId) {
    return cartDataSource.addOrRemoveCart(productId);
  }

  @override
  Future updateCartQuantity(String productId) {
    return cartDataSource.updateCartQuantity(productId);
  }
}
