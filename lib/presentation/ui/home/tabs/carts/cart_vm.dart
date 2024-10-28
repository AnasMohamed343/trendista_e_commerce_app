import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/domain/usecases/get_cartitems_usecase.dart';

@injectable
class CartVM extends Cubit<CartState> {
  GetCartItemsUseCase getCartItemsUseCase;

  List<Product>? _cartItems;
  Map<String, int> quantities = {}; // Store product quantities by product ID

  CartVM({required this.getCartItemsUseCase})
      : super(CartLoadingState(message: 'Loading...'));

  void initPage() async {
    emit(CartLoadingState(message: 'Loading...'));
    try {
      _cartItems = await getCartItemsUseCase.invoke();
      var totalPrice = _cartItems?.fold(0, (sum, product) {
        var productQuantity = quantities[product.id.toString()] ?? 1;
        return sum + (product.price ?? 0) * productQuantity;
      });
      emit(CartSuccessState(cartItems: _cartItems, totalPrice: totalPrice));
    } catch (e) {
      emit(CartErrorState(errorMessage: e.toString()));
    }
  }

  void addOrRemoveCart(String productId) async {
    try {
      // Optimistically update cart items locally
      var existingProductIndex = _cartItems
          ?.indexWhere((product) => product.id.toString() == productId);

      if (existingProductIndex != null && existingProductIndex != -1) {
        // Product already exists in the cart, remove it
        _cartItems?.removeAt(existingProductIndex);
      } else {
        // Product is not in the cart, add it
        var productToAdd = Product(
            id: int.parse(productId),
            inCart: true); // Assuming inCart is a boolean property
        _cartItems?.add(productToAdd);
      }

      // Recalculate the total price based on the updated cart
      var totalPrice = _cartItems?.fold(0, (sum, product) {
        var productQuantity = quantities[product.id.toString()] ?? 1;
        return sum + (product.price ?? 0) * productQuantity;
      });

      // Emit the updated state immediately
      emit(CartSuccessState(cartItems: _cartItems, totalPrice: totalPrice));

      // Perform the actual API call to update the cart on the server
      await getCartItemsUseCase.addOrRemoveCart(productId);

      // After successful API call, refresh the cart items and total price from the server
      _cartItems = await getCartItemsUseCase.invoke();
      totalPrice = _cartItems?.fold(0, (sum, product) {
        var productQuantity = quantities[product.id.toString()] ?? 1;
        return sum! + (product.price ?? 0) * productQuantity;
      });

      emit(CartSuccessState(cartItems: _cartItems, totalPrice: totalPrice));
    } catch (e) {
      emit(CartErrorState(errorMessage: e.toString()));
    }
  }

  bool isAddedToCart(String productId) {
    if (_cartItems == null || _cartItems!.isEmpty) {
      return false;
    }
    return _cartItems!.any((product) =>
        product.id.toString() == productId && product.inCart == true);
  }

  void updateCartQuantity(String productId, int quantity) async {
    try {
      // Update the quantity in the local map
      quantities[productId] = quantity;

      // Calculate the total price based on the updated quantities
      var totalPrice = _cartItems?.fold(0, (sum, product) {
        var productQuantity = quantities[product.id.toString()] ?? 1;
        return sum + (product.price ?? 0) * productQuantity;
      });

      emit(CartSuccessState(
        cartItems: _cartItems,
        totalPrice: totalPrice,
        quantity: quantity,
      ));
    } catch (e) {
      emit(CartErrorState(errorMessage: e.toString()));
    }
  }

  int getQuantity(String productId) {
    return quantities[productId] ?? 1; // Default quantity to 1 if not found
  }

  @override
  void onChange(Change<CartState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change);
  }
}

sealed class CartState {}

class CartLoadingState extends CartState {
  final String message;
  CartLoadingState({required this.message});
}

class CartErrorState extends CartState {
  final String? errorMessage;
  CartErrorState({this.errorMessage});
}

class CartSuccessState extends CartState {
  final List<Product>? cartItems;
  final int? totalPrice;
  final int? quantity;
  CartSuccessState({this.cartItems, this.totalPrice = 0, this.quantity});
}
