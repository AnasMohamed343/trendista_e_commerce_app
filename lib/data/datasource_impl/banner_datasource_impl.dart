import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/api_manager/api_manager.dart';
import 'package:trendista_e_commerce/data/datasource_contract/banner_datasource.dart';
import 'package:trendista_e_commerce/domain/entities/BannerEntity.dart';

@Injectable(as: BannerDataSource)
class BannerDataSourceImpl extends BannerDataSource {
  ApiManager apiManager;

  @factoryMethod
  BannerDataSourceImpl({required this.apiManager});

  @override
  Future<List<BannerEntity>?> getBanners() async {
    var response = await apiManager.getBanners();
    return response.data?.map((bannerDto) => bannerDto.toBanner()).toList();
  }
}
