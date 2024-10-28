import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/domain/repository/details_repository.dart';

@injectable
class GetProductDetailsUseCase {
  DetailsRepository detailsRepository;
  @factoryMethod
  GetProductDetailsUseCase({required this.detailsRepository});
  Future<Product?> invoke(int productId) async {
    return await detailsRepository.getProductDetails(productId);
  }
}
