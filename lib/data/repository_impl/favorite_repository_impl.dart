import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/datasource_contract/favorite_datasource.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/domain/repository/favorite_repository.dart';

@Injectable(as: FavoriteRepository)
class FavoriteRepositoryImpl extends FavoriteRepository {
  FavoriteDataSource favoriteDataSource;
  @factoryMethod
  FavoriteRepositoryImpl({required this.favoriteDataSource});
  @override
  Future<List<Product>?> getFavorites() {
    return favoriteDataSource.getFavorites();
  }

  @override
  Future<void> addOrRemoveFavorite(String productId) {
    return favoriteDataSource.addOrRemoveFavorite(productId);
  }
}
