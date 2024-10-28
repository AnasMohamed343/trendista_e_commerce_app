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
import '../data/datasource_contract/auth_datasource.dart' as _i12;
import '../data/datasource_contract/banner_datasource.dart' as _i18;
import '../data/datasource_contract/cart_datasource.dart' as _i10;
import '../data/datasource_contract/categories_datasource.dart' as _i16;
import '../data/datasource_contract/details_datasource.dart' as _i6;
import '../data/datasource_contract/favorite_datasource.dart' as _i8;
import '../data/datasource_contract/prands_datasource.dart' as _i4;
import '../data/datasource_contract/product_datasource.dart' as _i14;
import '../data/datasource_impl/auth_datasource_impl.dart' as _i13;
import '../data/datasource_impl/banner_datasource_impl.dart' as _i19;
import '../data/datasource_impl/brands_datasource_impl.dart' as _i5;
import '../data/datasource_impl/cart_datasource_impl.dart' as _i11;
import '../data/datasource_impl/categories_datasource_impl.dart' as _i17;
import '../data/datasource_impl/details_datasource_impl.dart' as _i7;
import '../data/datasource_impl/favorite_datasource_impl.dart' as _i9;
import '../data/datasource_impl/products_datasource_impl.dart' as _i15;
import '../data/repository_impl/auth_repository_impl.dart' as _i34;
import '../data/repository_impl/banner_repository_impl.dart' as _i25;
import '../data/repository_impl/brands_repository_impl.dart' as _i32;
import '../data/repository_impl/cart_repository_impl.dart' as _i39;
import '../data/repository_impl/categories_repo_impl.dart' as _i23;
import '../data/repository_impl/details_repository_impl.dart' as _i21;
import '../data/repository_impl/favorite_repository_impl.dart' as _i27;
import '../data/repository_impl/products_repository_impl.dart' as _i29;
import '../domain/repository/auth_repository.dart' as _i33;
import '../domain/repository/banners_repository.dart' as _i24;
import '../domain/repository/brands_repository.dart' as _i31;
import '../domain/repository/cart_repository.dart' as _i38;
import '../domain/repository/categories_repo_contract.dart' as _i22;
import '../domain/repository/details_repository.dart' as _i20;
import '../domain/repository/favorite_repository.dart' as _i26;
import '../domain/repository/products_repository.dart' as _i28;
import '../domain/usecases/get_banners_usecase.dart' as _i30;
import '../domain/usecases/get_brands_usecase.dart' as _i35;
import '../domain/usecases/get_cartitems_usecase.dart' as _i43;
import '../domain/usecases/get_categories_usecase.dart' as _i36;
import '../domain/usecases/get_favorites_usecase.dart' as _i40;
import '../domain/usecases/get_product_details_usecase.dart' as _i41;
import '../domain/usecases/get_products_usecase.dart' as _i37;
import '../domain/usecases/get_profiledata_usecase.dart' as _i48;
import '../domain/usecases/sign_in_usecase.dart' as _i46;
import '../domain/usecases/sign_up_usecase.dart' as _i47;
import '../presentation/ui/details_screen/product_details_vm.dart' as _i50;
import '../presentation/ui/home/tabs/carts/cart_vm.dart' as _i53;
import '../presentation/ui/home/tabs/category_tab/category_tab_vm.dart' as _i44;
import '../presentation/ui/home/tabs/favorite_tab/favorite_tab_vm.dart' as _i51;
import '../presentation/ui/home/tabs/home_tab/home_tab_vm.dart' as _i42;
import '../presentation/ui/home/tabs/products_tab/products_tab_vm.dart' as _i45;
import '../presentation/ui/home/tabs/profile_tab/profile_tab_vm.dart' as _i49;
import '../presentation/ui/sign_in/sign_in_viewModel.dart' as _i54;
import '../presentation/ui/sign_up/sign_up_viewModel.dart' as _i52;

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
    gh.factory<_i6.DetailsDataSource>(
        () => _i7.DetailsDataSourceImpl(apiManager: gh<_i3.ApiManager>()));
    gh.factory<_i8.FavoriteDataSource>(
        () => _i9.FavoriteDataSourceImpl(apiManager: gh<_i3.ApiManager>()));
    gh.factory<_i10.CartDataSource>(
        () => _i11.CartDataSourceImpl(apiManager: gh<_i3.ApiManager>()));
    gh.factory<_i12.AuthDataSource>(
        () => _i13.AuthDataSourceImpl(apiManager: gh<_i3.ApiManager>()));
    gh.factory<_i14.ProductDataSource>(
        () => _i15.ProductsDataSourceImpl(apiManager: gh<_i3.ApiManager>()));
    gh.factory<_i16.CategoriesDataSource>(
        () => _i17.CategoriesDataSourceImpl(apiManager: gh<_i3.ApiManager>()));
    gh.factory<_i18.BannerDataSource>(
        () => _i19.BannerDataSourceImpl(apiManager: gh<_i3.ApiManager>()));
    gh.factory<_i20.DetailsRepository>(() => _i21.DetailsRepositoryImpl(
        detailsDataSource: gh<_i6.DetailsDataSource>()));
    gh.factory<_i22.CategoriesRepository>(() => _i23.CategoriesRepositoryImpl(
        categoriesDataSource: gh<_i16.CategoriesDataSource>()));
    gh.factory<_i24.BannerRepository>(() => _i25.BannerRepositoryImpl(
        bannerDataSource: gh<_i18.BannerDataSource>()));
    gh.factory<_i26.FavoriteRepository>(() => _i27.FavoriteRepositoryImpl(
        favoriteDataSource: gh<_i8.FavoriteDataSource>()));
    gh.factory<_i28.ProductRepository>(() => _i29.ProductRepositoryImpl(
        productDataSource: gh<_i14.ProductDataSource>()));
    gh.factory<_i30.GetBannersUseCase>(() =>
        _i30.GetBannersUseCase(bannerRepository: gh<_i24.BannerRepository>()));
    gh.factory<_i31.BrandsRepository>(() => _i32.BrandsRepositoryImpl(
        brandsDataSource: gh<_i4.BrandsDataSource>()));
    gh.factory<_i33.AuthRepository>(() =>
        _i34.AuthRepositoryImpl(authDataSource: gh<_i12.AuthDataSource>()));
    gh.factory<_i35.GetBrandsUseCase>(() =>
        _i35.GetBrandsUseCase(brandsRepository: gh<_i31.BrandsRepository>()));
    gh.factory<_i36.GetCategoriesUseCase>(() => _i36.GetCategoriesUseCase(
        categoriesRepository: gh<_i22.CategoriesRepository>()));
    gh.factory<_i37.GetProductsUseCase>(() => _i37.GetProductsUseCase(
        productRepository: gh<_i28.ProductRepository>()));
    gh.factory<_i38.CartRepository>(() =>
        _i39.CartRepositoryImpl(cartDataSource: gh<_i10.CartDataSource>()));
    gh.factory<_i40.GetFavoritesUseCase>(() => _i40.GetFavoritesUseCase(
        favoriteRepository: gh<_i26.FavoriteRepository>()));
    gh.factory<_i41.GetProductDetailsUseCase>(() =>
        _i41.GetProductDetailsUseCase(
            detailsRepository: gh<_i20.DetailsRepository>()));
    gh.factory<_i42.HomeTabVM>(() => _i42.HomeTabVM(
          getBannersUseCase: gh<_i30.GetBannersUseCase>(),
          getCategoriesUseCase: gh<_i36.GetCategoriesUseCase>(),
          getBrandsUseCase: gh<_i35.GetBrandsUseCase>(),
          getProductsUseCase: gh<_i37.GetProductsUseCase>(),
        ));
    gh.factory<_i43.GetCartItemsUseCase>(() =>
        _i43.GetCartItemsUseCase(cartRepository: gh<_i38.CartRepository>()));
    gh.factory<_i44.CategoryTabVM>(() => _i44.CategoryTabVM(
        getCategoriesUseCase: gh<_i36.GetCategoriesUseCase>()));
    gh.factory<_i45.ProductsTabVM>(() =>
        _i45.ProductsTabVM(getProductsUseCase: gh<_i37.GetProductsUseCase>()));
    gh.factory<_i46.SignInUseCase>(
        () => _i46.SignInUseCase(authRepository: gh<_i33.AuthRepository>()));
    gh.factory<_i47.SignUpUseCase>(
        () => _i47.SignUpUseCase(authRepository: gh<_i33.AuthRepository>()));
    gh.factory<_i48.GetProfileDataUseCase>(() =>
        _i48.GetProfileDataUseCase(authRepository: gh<_i33.AuthRepository>()));
    gh.factory<_i49.ProfileTabVM>(() => _i49.ProfileTabVM(
        getProfileDataUseCase: gh<_i48.GetProfileDataUseCase>()));
    gh.factory<_i50.ProductDetailsVM>(() => _i50.ProductDetailsVM(
        getProductDetailsUseCase: gh<_i41.GetProductDetailsUseCase>()));
    gh.factory<_i51.FavoriteTabVM>(() => _i51.FavoriteTabVM(
        getFavoritesUseCase: gh<_i40.GetFavoritesUseCase>()));
    gh.factory<_i52.SignUpViewModel>(
        () => _i52.SignUpViewModel(signUpUseCase: gh<_i47.SignUpUseCase>()));
    gh.factory<_i53.CartVM>(
        () => _i53.CartVM(getCartItemsUseCase: gh<_i43.GetCartItemsUseCase>()));
    gh.factory<_i54.SignInViewModel>(
        () => _i54.SignInViewModel(signInUseCase: gh<_i46.SignInUseCase>()));
    return this;
  }
}
