import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/domain/entities/cartitem_entity.dart';
import 'package:trendista_e_commerce/domain/usecases/get_cartitems_usecase.dart';

class CartVM extends ChangeNotifier {
  final GetCartItemsUseCase getCartItemsUseCase;

  CartVM({required this.getCartItemsUseCase});

  List<CartItemEntity>? _cartItems;
  int? _totalPrice;
  bool _isLoading = false;
  String? _errorMessage;

  List<CartItemEntity>? get cartItems => _cartItems;
  int? get totalPrice => _totalPrice;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> initPage() async {
    _isLoading = true;
    notifyListeners();

    try {
      _cartItems = await getCartItemsUseCase.invoke();
      _totalPrice = await getCartItemsUseCase.getTotalPrice();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addOrRemoveCart(String productId) async {
    try {
      // Optimistically update cart items locally
      var existingCartItemIndex = _cartItems?.indexWhere(
          (cartItem) => (cartItem.product!.id).toString() == productId);

      if (existingCartItemIndex != null && existingCartItemIndex != -1) {
        // Remove from local cart and adjust total price locally
        var removedItem = _cartItems!.removeAt(existingCartItemIndex);
        _totalPrice = _totalPrice! -
            (removedItem.product!.price ?? 0 * (removedItem.quantity ?? 0));
      } else {
        // Add to local cart and adjust total price locally
        var productToAdd = Product(id: int.parse(productId), inCart: true);
        var cartItemToAdd = CartItemEntity(product: productToAdd, quantity: 1);
        _cartItems!.add(cartItemToAdd);
        _totalPrice = _totalPrice! + (productToAdd.price ?? 0);
      }

      notifyListeners();

      // Perform the API call to update the cart on the server
      await getCartItemsUseCase.addOrRemoveCart(productId);

      // Optionally re-fetch entire cart if necessary
      _cartItems = await getCartItemsUseCase.invoke();
      _totalPrice = await getCartItemsUseCase.getTotalPrice();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  bool isAddedToCart(String productId) {
    if (_cartItems == null || _cartItems!.isEmpty) {
      return false;
    }
    return _cartItems!.any((cartItem) =>
        (cartItem.product!.id).toString() == productId &&
        cartItem.product!.inCart == true); // Access inCart through product
  }

  Future<void> updateCartQuantity(int cartItemId, String quantity) async {
    try {
      // Find the item in the cart and update its quantity optimistically
      var cartItem = _cartItems?.firstWhere((item) => item.id == cartItemId);
      if (cartItem != null) {
        int? oldQuantity = cartItem.quantity;
        int newQuantity = int.parse(quantity);
        cartItem.quantity = newQuantity;

        // Adjust total price locally based on quantity change
        int priceChange =
            (newQuantity - oldQuantity!) * (cartItem.product!.price ?? 0);
        _totalPrice = _totalPrice! + priceChange;

        notifyListeners();

        // Update the cart quantity on the server
        await getCartItemsUseCase.updateCartQuantity(cartItemId, quantity);

        // Optionally re-fetch entire cart if necessary
        _cartItems = await getCartItemsUseCase.invoke();
        _totalPrice = await getCartItemsUseCase.getTotalPrice();
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  int getQuantity(String s) {
    if (_cartItems == null || _cartItems!.isEmpty) {
      return 0;
    }
    return _cartItems!
        .firstWhere((cartItem) =>
            (cartItem.product!.id).toString() == s &&
            cartItem.product!.inCart == true)
        .quantity!;
  }

  int getTotalPriceForCart(String s) {
    if (_cartItems == null || _cartItems!.isEmpty) {
      return 0;
    }
    var cartItemPrice = _cartItems!
        .firstWhere((cartItem) =>
            (cartItem.product!.id).toString() == s &&
            cartItem.product!.inCart == true)
        .product!
        .price!;
    var totalPrice = cartItemPrice * getQuantity(s);
    return totalPrice;
  }

  Future<void> refreshCart() async {
    _cartItems = await getCartItemsUseCase.invoke();
    _totalPrice = await getCartItemsUseCase.getTotalPrice();
    notifyListeners();
  }
}
