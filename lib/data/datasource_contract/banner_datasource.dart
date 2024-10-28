import 'package:trendista_e_commerce/domain/entities/BannerEntity.dart';

abstract class BannerDataSource {
  Future<List<BannerEntity>?> getBanners();
}
