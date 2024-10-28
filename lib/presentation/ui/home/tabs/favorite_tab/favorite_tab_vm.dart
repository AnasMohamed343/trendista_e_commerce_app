// i used FavoriteProvider instead of FavoriteTabVM
import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/domain/usecases/get_favorites_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class FavoriteTabVM extends Cubit<FavoriteTabState> {
  GetFavoritesUseCase getFavoritesUseCase;

  @factoryMethod
  FavoriteTabVM({required this.getFavoritesUseCase})
      : super(FavoriteTabLoading(message: 'Loading..'));

  Set<String> _favoriteProductIds = HashSet<String>();
  List<Product> _favoriteProducts = [];

  void initPage() async {
    emit(FavoriteTabLoading(message: 'Loading..'));
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? savedFavorites = prefs.getStringList(kFavoriteProductsIds);

      if (savedFavorites != null) {
        _favoriteProductIds.addAll(savedFavorites);
      }

      var favorites = await getFavoritesUseCase.invoke();

      // Update the local lists with the fetched products
      _updateFavoriteLists(favorites!); // Update both lists

      emit(FavoriteTabSuccess(favorites: _favoriteProducts));
    } catch (e) {
      emit(FavoriteTabError(errorMessage: e.toString()));
    }
  }

  void addOrRemoveFavorite(String productId) async {
    bool isFavorite = _favoriteProductIds.contains(productId);
    if (isFavorite) {
      _favoriteProductIds.remove(productId);
      _favoriteProducts
          .removeWhere((product) => product.id.toString() == productId);
    } else {
      _favoriteProductIds.add(productId);
      _favoriteProducts.add(Product(id: int.parse(productId)));
    }

    // Emit the updated favorite state immediately
    emit(FavoriteTabSuccess(favorites: _favoriteProducts));

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
          kFavoriteProductsIds, _favoriteProductIds.toList());
      await getFavoritesUseCase.addOrRemoveFavorite(productId);
    } catch (e) {
      emit(FavoriteTabError(errorMessage: e.toString()));
    }
  }

  bool isFavorite(String productId) {
    return _favoriteProductIds.contains(productId);
  }

  // Update both _favoriteProductIds and _favoriteProducts
  void _updateFavoriteLists(List<Product> products) {
    _favoriteProducts = products;
    _favoriteProductIds =
        products.map((product) => product.id.toString()).toSet();
  }
}

sealed class FavoriteTabState {}

class FavoriteTabLoading extends FavoriteTabState {
  String message;
  FavoriteTabLoading({required this.message});
}

class FavoriteTabError extends FavoriteTabState {
  String? errorMessage;
  FavoriteTabError({this.errorMessage});
}

class FavoriteTabSuccess extends FavoriteTabState {
  List<Product>? favorites;
  FavoriteTabSuccess({this.favorites});
}
