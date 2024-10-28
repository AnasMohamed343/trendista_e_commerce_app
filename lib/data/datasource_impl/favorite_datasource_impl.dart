import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/api_manager/api_manager.dart';
import 'package:trendista_e_commerce/data/datasource_contract/favorite_datasource.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';

@Injectable(as: FavoriteDataSource)
class FavoriteDataSourceImpl extends FavoriteDataSource {
  ApiManager apiManager;
  @factoryMethod
  FavoriteDataSourceImpl({required this.apiManager});
  @override
  Future<List<Product>?> getFavorites() async {
    var response = await apiManager.getFavorites();
    return response.data?.data
        ?.map((favProductDto) => favProductDto.toProduct())
        .toList();
  }

  @override
  Future<void> addOrRemoveFavorite(String productId) async {
    var response = await apiManager.addOrRemoveFavorite(productId: productId);
    return response.message;
  }
}
