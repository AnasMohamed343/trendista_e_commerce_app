import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/domain/repository/favorite_repository.dart';

@injectable
class GetFavoritesUseCase {
  FavoriteRepository favoriteRepository;
  @factoryMethod
  GetFavoritesUseCase({required this.favoriteRepository});
  Future<List<Product>?> invoke() {
    return favoriteRepository.getFavorites();
  }

  Future<void> addOrRemoveFavorite(String productId) {
    return favoriteRepository.addOrRemoveFavorite(productId);
  }
}
