import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/datasource_contract/prands_datasource.dart';
import 'package:trendista_e_commerce/domain/entities/Brand.dart';
import 'package:trendista_e_commerce/domain/repository/brands_repository.dart';

@Injectable(as: BrandsRepository)
class BrandsRepositoryImpl extends BrandsRepository {
  BrandsDataSource brandsDataSource;
  @factoryMethod
  BrandsRepositoryImpl({required this.brandsDataSource});
  @override
  Future<List<Brand>?> getBrands() {
    return brandsDataSource.getBrands();
  }
}
