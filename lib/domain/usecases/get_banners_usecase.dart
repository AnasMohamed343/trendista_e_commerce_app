import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/entities/BannerEntity.dart';
import 'package:trendista_e_commerce/domain/repository/banners_repository.dart';

@injectable
class GetBannersUseCase {
  BannerRepository bannerRepository;
  @factoryMethod
  GetBannersUseCase({required this.bannerRepository});
  Future<List<BannerEntity>?> invoke() {
    return bannerRepository.getBanners();
  }
}
