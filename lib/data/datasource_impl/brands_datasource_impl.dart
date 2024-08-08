import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/api_manager/api_manager.dart';
import 'package:trendista_e_commerce/data/datasource_contract/prands_datasource.dart';
import 'package:trendista_e_commerce/domain/entities/Brand.dart';

@Injectable(as: BrandsDataSource)
class BrandsDataSourceImpl extends BrandsDataSource {
  ApiManager apiManager;
  @factoryMethod
  BrandsDataSourceImpl({required this.apiManager});
  @override
  Future<List<Brand>?> getBrands() async {
    var response = await apiManager.getBrands();
    return response.data?.map((brandDto) => brandDto.toBrand()).toList();
  }
}
