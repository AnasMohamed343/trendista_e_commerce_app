import 'package:trendista_e_commerce/domain/entities/Brand.dart';

abstract class BrandsDataSource {
  Future<List<Brand>?> getBrands();
}
