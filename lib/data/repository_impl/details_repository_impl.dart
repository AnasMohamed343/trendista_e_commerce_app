import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/datasource_contract/details_datasource.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/domain/repository/details_repository.dart';

@Injectable(as: DetailsRepository)
class DetailsRepositoryImpl extends DetailsRepository {
  DetailsDataSource detailsDataSource;
  @factoryMethod
  DetailsRepositoryImpl({required this.detailsDataSource});
  @override
  Future<Product?> getProductDetails(int productId) {
    return detailsDataSource.getProductDetails(productId);
  }
}
