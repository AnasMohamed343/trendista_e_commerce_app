import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/datasource_contract/banner_datasource.dart';
import 'package:trendista_e_commerce/domain/entities/BannerEntity.dart';
import 'package:trendista_e_commerce/domain/repository/banners_repository.dart';

@Injectable(as: BannerRepository)
class BannerRepositoryImpl extends BannerRepository {
  BannerDataSource bannerDataSource;
  @factoryMethod
  BannerRepositoryImpl({required this.bannerDataSource});
  @override
  Future<List<BannerEntity>?> getBanners() {
    return bannerDataSource.getBanners();
  }
}
