// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/api_manager/api_manager.dart' as _i3;
import '../data/datasource_contract/categories_datasource.dart' as _i8;
import '../data/datasource_contract/prands_datasource.dart' as _i4;
import '../data/datasource_contract/product_datasource.dart' as _i6;
import '../data/datasource_impl/brands_datasource_impl.dart' as _i5;
import '../data/datasource_impl/categories_datasource_impl.dart' as _i9;
import '../data/datasource_impl/products_datasource_impl.dart' as _i7;
import '../data/repository_impl/brands_repository_impl.dart' as _i15;
import '../data/repository_impl/categories_repo_impl.dart' as _i11;
import '../data/repository_impl/products_repository_impl.dart' as _i13;
import '../domain/repository/brands_repository.dart' as _i14;
import '../domain/repository/categories_repo_contract.dart' as _i10;
import '../domain/repository/products_repository.dart' as _i12;
import '../domain/usecases/get_brands_usecase.dart' as _i16;
import '../domain/usecases/get_categories_usecase.dart' as _i17;
import '../domain/usecases/get_products_usecase.dart' as _i18;
import '../presentation/ui/home/tabs/category_tab/category_tab_vm.dart' as _i20;
import '../presentation/ui/home/tabs/home_tab/home_tab_vm.dart' as _i19;
import '../presentation/ui/home/tabs/products_tab/products_tab_vm.dart' as _i21;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.ApiManager>(() => _i3.ApiManager());
    gh.factory<_i4.BrandsDataSource>(
        () => _i5.BrandsDataSourceImpl(apiManager: gh<_i3.ApiManager>()));
    gh.factory<_i6.ProductDataSource>(
        () => _i7.ProductsDataSourceImpl(apiManager: gh<_i3.ApiManager>()));
    gh.factory<_i8.CategoriesDataSource>(
        () => _i9.CategoriesDataSourceImpl(apiManager: gh<_i3.ApiManager>()));
    gh.factory<_i10.CategoriesRepository>(() => _i11.CategoriesRepositoryImpl(
        categoriesDataSource: gh<_i8.CategoriesDataSource>()));
    gh.factory<_i12.ProductRepository>(() => _i13.ProductRepositoryImpl(
        productDataSource: gh<_i6.ProductDataSource>()));
    gh.factory<_i14.BrandsRepository>(() => _i15.BrandsRepositoryImpl(
        brandsDataSource: gh<_i4.BrandsDataSource>()));
    gh.factory<_i16.GetBrandsUseCase>(() =>
        _i16.GetBrandsUseCase(brandsRepository: gh<_i14.BrandsRepository>()));
    gh.factory<_i17.GetCategoriesUseCase>(() => _i17.GetCategoriesUseCase(
        categoriesRepository: gh<_i10.CategoriesRepository>()));
    gh.factory<_i18.GetProductsUseCase>(() => _i18.GetProductsUseCase(
        productRepository: gh<_i12.ProductRepository>()));
    gh.factory<_i19.HomeTabVM>(() => _i19.HomeTabVM(
          getCategoriesUseCase: gh<_i17.GetCategoriesUseCase>(),
          getBrandsUseCase: gh<_i16.GetBrandsUseCase>(),
          getProductsUseCase: gh<_i18.GetProductsUseCase>(),
        ));
    gh.factory<_i20.CategoryTabVM>(() => _i20.CategoryTabVM(
        getCategoriesUseCase: gh<_i17.GetCategoriesUseCase>()));
    gh.factory<_i21.ProductsTabVM>(() =>
        _i21.ProductsTabVM(getProductsUseCase: gh<_i18.GetProductsUseCase>()));
    return this;
  }
}
