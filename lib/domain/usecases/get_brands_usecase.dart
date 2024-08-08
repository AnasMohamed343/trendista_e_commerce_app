import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/entities/Brand.dart';
import 'package:trendista_e_commerce/domain/repository/brands_repository.dart';

@injectable
class GetBrandsUseCase {
  BrandsRepository brandsRepository;
  @factoryMethod
  GetBrandsUseCase({required this.brandsRepository});
  Future<List<Brand>?> invoke() {
    return brandsRepository.getBrands();
  }
}
