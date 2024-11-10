import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/domain/entities/cartitem_entity.dart';
import 'package:trendista_e_commerce/domain/repository/cart_repository.dart';

@injectable
class GetCartItemsUseCase {
  // useCase => is responsible for two reasons:
  // functional requirements (from user side)
  // businessLogic
  CartRepository cartRepository;
  @factoryMethod
  GetCartItemsUseCase({required this.cartRepository});

  // Future<List<Product>?> invoke() {
  //   return cartRepository.getCart();
  // }

  Future<List<CartItemEntity>?> invoke() {
    return cartRepository.getCart();
  }

  Future getTotalPrice() {
    return cartRepository.getTotalPrice();
  }

  Future<void> addOrRemoveCart(String productId) {
    return cartRepository.addOrRemoveCart(productId);
  }

  Future updateCartQuantity(int cartItemId, String quantity) {
    return cartRepository.updateCartQuantity(cartItemId, quantity);
  }
}
