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
import '../data/datasource_contract/auth_datasource.dart' as _i6;
import '../data/datasource_contract/categories_datasource.dart' as _i10;
import '../data/datasource_contract/prands_datasource.dart' as _i4;
import '../data/datasource_contract/product_datasource.dart' as _i8;
import '../data/datasource_impl/auth_datasource_impl.dart' as _i7;
import '../data/datasource_impl/brands_datasource_impl.dart' as _i5;
import '../data/datasource_impl/categories_datasource_impl.dart' as _i11;
import '../data/datasource_impl/products_datasource_impl.dart' as _i9;
import '../data/repository_impl/auth_repository_impl.dart' as _i19;
import '../data/repository_impl/brands_repository_impl.dart' as _i17;
import '../data/repository_impl/categories_repo_impl.dart' as _i13;
import '../data/repository_impl/products_repository_impl.dart' as _i15;
import '../domain/repository/auth_repository.dart' as _i18;
import '../domain/repository/brands_repository.dart' as _i16;
import '../domain/repository/categories_repo_contract.dart' as _i12;
import '../domain/repository/products_repository.dart' as _i14;
import '../domain/usecases/get_brands_usecase.dart' as _i20;
import '../domain/usecases/get_categories_usecase.dart' as _i21;
import '../domain/usecases/get_products_usecase.dart' as _i22;
import '../domain/usecases/sign_in_usecase.dart' as _i27;
import '../domain/usecases/sign_up_usecase.dart' as _i26;
import '../presentation/ui/home/tabs/category_tab/category_tab_vm.dart' as _i24;
import '../presentation/ui/home/tabs/home_tab/home_tab_vm.dart' as _i23;
import '../presentation/ui/home/tabs/products_tab/products_tab_vm.dart' as _i25;
import '../presentation/ui/sign_in/sign_in_viewModel.dart' as _i29;
import '../presentation/ui/sign_up/sign_up_viewModel.dart' as _i28;

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
    gh.factory<_i6.AuthDataSource>(
        () => _i7.AuthDataSourceImpl(apiManager: gh<_i3.ApiManager>()));
    gh.factory<_i8.ProductDataSource>(
        () => _i9.ProductsDataSourceImpl(apiManager: gh<_i3.ApiManager>()));
    gh.factory<_i10.CategoriesDataSource>(
        () => _i11.CategoriesDataSourceImpl(apiManager: gh<_i3.ApiManager>()));
    gh.factory<_i12.CategoriesRepository>(() => _i13.CategoriesRepositoryImpl(
        categoriesDataSource: gh<_i10.CategoriesDataSource>()));
    gh.factory<_i14.ProductRepository>(() => _i15.ProductRepositoryImpl(
        productDataSource: gh<_i8.ProductDataSource>()));
    gh.factory<_i16.BrandsRepository>(() => _i17.BrandsRepositoryImpl(
        brandsDataSource: gh<_i4.BrandsDataSource>()));
    gh.factory<_i18.AuthRepository>(() =>
        _i19.AuthRepositoryImpl(authDataSource: gh<_i6.AuthDataSource>()));
    gh.factory<_i20.GetBrandsUseCase>(() =>
        _i20.GetBrandsUseCase(brandsRepository: gh<_i16.BrandsRepository>()));
    gh.factory<_i21.GetCategoriesUseCase>(() => _i21.GetCategoriesUseCase(
        categoriesRepository: gh<_i12.CategoriesRepository>()));
    gh.factory<_i22.GetProductsUseCase>(() => _i22.GetProductsUseCase(
        productRepository: gh<_i14.ProductRepository>()));
    gh.factory<_i23.HomeTabVM>(() => _i23.HomeTabVM(
          getCategoriesUseCase: gh<_i21.GetCategoriesUseCase>(),
          getBrandsUseCase: gh<_i20.GetBrandsUseCase>(),
          getProductsUseCase: gh<_i22.GetProductsUseCase>(),
        ));
    gh.factory<_i24.CategoryTabVM>(() => _i24.CategoryTabVM(
        getCategoriesUseCase: gh<_i21.GetCategoriesUseCase>()));
    gh.factory<_i25.ProductsTabVM>(() =>
        _i25.ProductsTabVM(getProductsUseCase: gh<_i22.GetProductsUseCase>()));
    gh.factory<_i26.SignUpUseCase>(
        () => _i26.SignUpUseCase(authRepository: gh<_i18.AuthRepository>()));
    gh.factory<_i27.SignInUseCase>(
        () => _i27.SignInUseCase(authRepository: gh<_i18.AuthRepository>()));
    gh.factory<_i28.SignUpViewModel>(
        () => _i28.SignUpViewModel(signUpUseCase: gh<_i26.SignUpUseCase>()));
    gh.factory<_i29.SignInViewModel>(
        () => _i29.SignInViewModel(signInUseCase: gh<_i27.SignInUseCase>()));
    return this;
  }
}
