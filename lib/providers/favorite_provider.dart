import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/domain/usecases/get_favorites_usecase.dart';
import 'package:trendista_e_commerce/domain/usecases/get_product_details_usecase.dart';

class FavoriteProvider extends ChangeNotifier {
  final GetFavoritesUseCase getFavoritesUseCase;
  final GetProductDetailsUseCase getProductDetailsUseCase;

  bool _isAddingFavorite = false;
  bool get isAddingFavorite => _isAddingFavorite;

  Set<String> _favoriteProductIds = {};
  List<Product> _favoriteProducts = [];

  List<Product> get favoriteProducts => _favoriteProducts;

  Set<String> get favoriteProductIds => _favoriteProductIds;

  FavoriteProvider({
    required this.getFavoritesUseCase,
    required this.getProductDetailsUseCase,
  }) {
    _loadFavoritesFromPreferences();
  }

  Future<void> fetchFavorites() async {
    try {
      var favorites = await getFavoritesUseCase.invoke();
      _favoriteProducts = favorites ?? [];
      _favoriteProductIds =
          _favoriteProducts.map((p) => p.id.toString()).toSet();
      notifyListeners();
    } catch (e) {
      print("Error fetching favorites: $e");
    }
  }

  Future<void> addOrRemoveFavorite(String productId) async {
    bool isAdding = !_favoriteProductIds.contains(productId);

    if (isAdding) {
      _isAddingFavorite = true;
      notifyListeners(); // Trigger loading state for adding
    }

    try {
      if (isAdding) {
        _favoriteProductIds.add(productId);
        _favoriteProducts.add(Product(id: int.parse(productId))); // Placeholder
      } else {
        _favoriteProductIds.remove(productId);
        _favoriteProducts
            .removeWhere((product) => product.id.toString() == productId);
      }

      notifyListeners();

      await getFavoritesUseCase.addOrRemoveFavorite(productId);

      if (isAdding) {
        final productDetails =
            await getProductDetailsUseCase.invoke(int.parse(productId));
        if (productDetails != null) {
          int index =
              _favoriteProducts.indexWhere((p) => p.id.toString() == productId);
          if (index != -1) {
            _favoriteProducts[index] = productDetails;
          }
        }
      }
    } catch (e) {
      print("Error adding/removing favorite: $e");
    } finally {
      _isAddingFavorite = false;
      notifyListeners();
    }

    _saveFavoritesToPreferences();
  }

  bool isFavorite(String productId) {
    return _favoriteProductIds.contains(productId);
  }

  // --- Helper functions for local storage persistence ---
  Future<void> _saveFavoritesToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        kFavoriteProductsIds, _favoriteProductIds.toList());
  }

  Future<void> _loadFavoritesFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedFavorites = prefs.getStringList(kFavoriteProductsIds);
    if (savedFavorites != null) {
      _favoriteProductIds = savedFavorites.toSet();
    }
    // Wait for the complete data fetch before finishing loading
    await fetchFavorites();
  }
}
