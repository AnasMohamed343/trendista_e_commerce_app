import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/api_manager/api_manager.dart';
import 'package:trendista_e_commerce/data/datasource_contract/product_datasource.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/domain/repository/products_repository.dart';

@Injectable(as: ProductDataSource)
class ProductsDataSourceImpl extends ProductDataSource {
  ApiManager apiManager;
  @factoryMethod
  ProductsDataSourceImpl({required this.apiManager});
  @override
  Future<List<Product>?> getProducts(
      {ProductSort? sortBy, String? categoryId}) async {
    var response = await apiManager.getProducts(categoryId: categoryId ?? '');
    return response.data?.map((productDto) => productDto.toProduct()).toList();
  }
}
