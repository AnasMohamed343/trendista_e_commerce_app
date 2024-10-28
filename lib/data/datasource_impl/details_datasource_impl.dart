import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/api_manager/api_manager.dart';
import 'package:trendista_e_commerce/data/datasource_contract/details_datasource.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';

@Injectable(as: DetailsDataSource)
class DetailsDataSourceImpl extends DetailsDataSource {
  ApiManager apiManager;
  @factoryMethod
  DetailsDataSourceImpl({required this.apiManager});
  @override
  Future<Product?> getProductDetails(int productId) async {
    var response = await apiManager.getProductDetails(productId);
    return response.data?.toProduct();
  }
}
