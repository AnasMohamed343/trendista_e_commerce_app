import 'package:trendista_e_commerce/domain/entities/Product.dart';

abstract class FavoriteDataSource {
  Future<List<Product>?> getFavorites();

  Future<void> addOrRemoveFavorite(String productId);
}
