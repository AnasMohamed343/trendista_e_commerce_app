import 'package:trendista_e_commerce/domain/entities/Brand.dart';

abstract class BrandsRepository {
  Future<List<Brand>?> getBrands();
}
