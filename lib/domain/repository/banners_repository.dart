import 'package:trendista_e_commerce/domain/entities/BannerEntity.dart';

abstract class BannerRepository {
  Future<List<BannerEntity>?> getBanners();
}
