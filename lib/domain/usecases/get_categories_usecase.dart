import 'package:injectable/injectable.dart';
//import 'package:trendista_e_commerce/domain/entities/route_e-commerce/Category.dart';
import 'package:trendista_e_commerce/domain/repository/categories_repo_contract.dart';

import 'package:trendista_e_commerce/domain/entities/Category.dart';

@injectable
class GetCategoriesUseCase {
  // useCase => is responsible for two reasons:
  // functional requirements (from user side)
  // businessLogic
  CategoriesRepository categoriesRepository;
  @factoryMethod
  GetCategoriesUseCase({required this.categoriesRepository});

  Future<List<Category>?> invoke() {
    return categoriesRepository.getCategories();
  }
}
