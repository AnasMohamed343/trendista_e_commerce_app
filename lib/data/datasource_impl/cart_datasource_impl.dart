import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/api_manager/api_manager.dart';
import 'package:trendista_e_commerce/data/datasource_contract/cart_datasource.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/domain/entities/cartitem_entity.dart';

@Injectable(as: CartDataSource)
class CartDataSourceImpl extends CartDataSource {
  ApiManager apiManager;
  @factoryMethod
  CartDataSourceImpl({required this.apiManager});

  // @override
  // Future<List<Product>?> getCart() async {
  //   var response = await apiManager.getCart();
  //   return response.data?.cartItems
  //       ?.map((cartItemDto) => cartItemDto.toProduct())
  //       .toList();
  // }

  @override
  Future getTotalPrice() async {
    var response = await apiManager.getCart();
    return response.data?.total?.toDouble().toInt() ?? 0;
  }

  @override
  Future<void> addOrRemoveCart(String productId) async {
    var response = await apiManager.addOrRemoveCart(
        productId: productId); // Update the API call to match cart behavior
    if (response.data == null) {
      throw Exception(response.message); // Handle error
    }
    return; // No need to return anything if the operation was successful
  }

  @override
  Future updateCartQuantity(int cartItemId, String quantity) async {
    var response = await apiManager.updateCartQuantity(
        cartItemId: cartItemId, quantity: quantity);
    //return quantity
    if (response.data == null) {
      throw Exception(response.message);
    }
    return response.data?.total;
    //return response.data?.total?.toDouble().toInt() ?? 0;
    //return response.data?.cartItems?.first.quantity ?? 0;
  }

  @override
  Future<List<CartItemEntity>?> getCart() async {
    var response = await apiManager.getCart();
    return response.data?.cartItems
        ?.map((cartItemDto) => cartItemDto.toCartItemEntity())
        .toList();
  }
}
