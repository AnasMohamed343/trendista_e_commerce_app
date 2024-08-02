import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/entities/Category.dart';
import 'package:trendista_e_commerce/domain/repository/categories_repo_contract.dart';

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
