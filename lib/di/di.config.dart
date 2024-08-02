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
import '../data/datasource_contract/categories_datasource.dart' as _i4;
import '../data/datasource_impl/categories_datasource_impl.dart' as _i5;
import '../data/repository_impl/categories_repo_impl.dart' as _i7;
import '../domain/repository/categories_repo_contract.dart' as _i6;
import '../domain/usecases/get_categories_usecase.dart' as _i8;
import '../presentation/ui/home/tabs/home_tab/home_tab_vm.dart' as _i9;

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
    gh.factory<_i4.CategoriesDataSource>(
        () => _i5.CategoriesDataSourceImpl(apiManager: gh<_i3.ApiManager>()));
    gh.factory<_i6.CategoriesRepository>(() => _i7.CategoriesRepositoryImpl(
        categoriesDataSource: gh<_i4.CategoriesDataSource>()));
    gh.factory<_i8.GetCategoriesUseCase>(() => _i8.GetCategoriesUseCase(
        categoriesRepository: gh<_i6.CategoriesRepository>()));
    gh.factory<_i9.HomeTabVM>(() =>
        _i9.HomeTabVM(getCategoriesUseCase: gh<_i8.GetCategoriesUseCase>()));
    return this;
  }
}
