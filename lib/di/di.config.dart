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
import '../data/datasource_contract/banner_datasource.dart' as _i24;
import '../data/datasource_contract/cart_datasource.dart' as _i10;
import '../data/datasource_contract/categories_datasource.dart' as _i22;
import '../data/datasource_contract/details_datasource.dart' as _i6;
import '../data/datasource_contract/favorite_datasource.dart' as _i8;
import '../data/datasource_contract/orders_datasource.dart' as _i14;
import '../data/datasource_contract/prands_datasource.dart' as _i4;
import '../data/datasource_contract/product_datasource.dart' as _i18;
import '../data/datasource_contract/profile_datasource.dart' as _i20;
import '../data/datasource_impl/auth_datasource_impl.dart' as _i13;
import '../data/datasource_impl/banner_datasource_impl.dart' as _i25;
import '../data/datasource_impl/brands_datasource_impl.dart' as _i5;
import '../data/datasource_impl/cart_datasource_impl.dart' as _i11;
import '../data/datasource_impl/categories_datasource_impl.dart' as _i23;
import '../data/datasource_impl/details_datasource_impl.dart' as _i7;
import '../data/datasource_impl/favorite_datasource_impl.dart' as _i9;
import '../data/datasource_impl/orders_datasource_impl.dart' as _i15;
import '../data/datasource_impl/products_datasource_impl.dart' as _i19;
import '../data/datasource_impl/profile_datasource_impl.dart' as _i21;
import '../data/repository_impl/auth_repository_impl.dart' as _i42;
import '../data/repository_impl/banner_repository_impl.dart' as _i31;
import '../data/repository_impl/brands_repository_impl.dart' as _i38;
import '../data/repository_impl/cart_repository_impl.dart' as _i48;
import '../data/repository_impl/categories_repo_impl.dart' as _i29;
import '../data/repository_impl/details_repository_impl.dart' as _i27;
import '../data/repository_impl/favorite_repository_impl.dart' as _i33;
import '../data/repository_impl/orders_repository_impl.dart' as _i17;
import '../data/repository_impl/products_repository_impl.dart' as _i35;
import '../data/repository_impl/profile_repository_impl.dart' as _i40;
import '../domain/repository/auth_repository.dart' as _i41;
import '../domain/repository/banners_repository.dart' as _i30;
import '../domain/repository/brands_repository.dart' as _i37;
import '../domain/repository/cart_repository.dart' as _i47;
import '../domain/repository/categories_repo_contract.dart' as _i28;
import '../domain/repository/details_repository.dart' as _i26;
import '../domain/repository/favorite_repository.dart' as _i32;
import '../domain/repository/orders_repository.dart' as _i16;
import '../domain/repository/products_repository.dart' as _i34;
import '../domain/repository/profile_repository.dart' as _i39;
import '../domain/usecases/get_banners_usecase.dart' as _i36;
import '../domain/usecases/get_brands_usecase.dart' as _i43;
import '../domain/usecases/get_cartitems_usecase.dart' as _i54;
import '../domain/usecases/get_categories_usecase.dart' as _i45;
import '../domain/usecases/get_favorites_usecase.dart' as _i51;
import '../domain/usecases/get_orders_usecase.dart' as _i44;
import '../domain/usecases/get_product_details_usecase.dart' as _i52;
import '../domain/usecases/get_products_usecase.dart' as _i46;
import '../domain/usecases/get_profiledata_usecase.dart' as _i50;
import '../domain/usecases/sign_in_usecase.dart' as _i57;
import '../domain/usecases/sign_up_usecase.dart' as _i58;
import '../presentation/ui/product_details_screen/product_details_vm.dart'
    as _i60;
import '../presentation/ui/home/tabs/carts/cart_vm.dart' as _i63;
import '../presentation/ui/home/tabs/category_tab/category_tab_vm.dart' as _i55;
import '../presentation/ui/home/tabs/favorite_tab/favorite_tab_vm.dart' as _i61;
import '../presentation/ui/home/tabs/home_tab/home_tab_vm.dart' as _i53;
import '../presentation/ui/home/tabs/products_tab/products_tab_vm.dart' as _i56;
import '../presentation/ui/home/tabs/profile_tab/orders_screen/orders_vm.dart'
    as _i49;
import '../presentation/ui/home/tabs/profile_tab/profile_tab_vm.dart' as _i59;
import '../presentation/ui/sign_in/sign_in_viewModel.dart' as _i64;
import '../presentation/ui/sign_up/sign_up_viewModel.dart' as _i62;

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
    gh.factory<_i14.OrdersDatasource>(
        () => _i15.OrdersDatasourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i16.OrdersRepository>(() => _i17.OrdersRepositoryImpl(
        ordersDatasource: gh<_i14.OrdersDatasource>()));
    gh.factory<_i18.ProductDataSource>(
        () => _i19.ProductsDataSourceImpl(apiManager: gh<_i3.ApiManager>()));
    gh.factory<_i20.ProfileDataSource>(
        () => _i21.ProfileDataSourceImpl(apiManager: gh<_i3.ApiManager>()));
    gh.factory<_i22.CategoriesDataSource>(
        () => _i23.CategoriesDataSourceImpl(apiManager: gh<_i3.ApiManager>()));
    gh.factory<_i24.BannerDataSource>(
        () => _i25.BannerDataSourceImpl(apiManager: gh<_i3.ApiManager>()));
    gh.factory<_i26.DetailsRepository>(() => _i27.DetailsRepositoryImpl(
        detailsDataSource: gh<_i6.DetailsDataSource>()));
    gh.factory<_i28.CategoriesRepository>(() => _i29.CategoriesRepositoryImpl(
        categoriesDataSource: gh<_i22.CategoriesDataSource>()));
    gh.factory<_i30.BannerRepository>(() => _i31.BannerRepositoryImpl(
        bannerDataSource: gh<_i24.BannerDataSource>()));
    gh.factory<_i32.FavoriteRepository>(() => _i33.FavoriteRepositoryImpl(
        favoriteDataSource: gh<_i8.FavoriteDataSource>()));
    gh.factory<_i34.ProductRepository>(() => _i35.ProductRepositoryImpl(
        productDataSource: gh<_i18.ProductDataSource>()));
    gh.factory<_i36.GetBannersUseCase>(() =>
        _i36.GetBannersUseCase(bannerRepository: gh<_i30.BannerRepository>()));
    gh.factory<_i37.BrandsRepository>(() => _i38.BrandsRepositoryImpl(
        brandsDataSource: gh<_i4.BrandsDataSource>()));
    gh.factory<_i39.ProfileRepository>(() => _i40.ProfileRepositoryImpl(
        profileDataSource: gh<_i20.ProfileDataSource>()));
    gh.factory<_i41.AuthRepository>(() =>
        _i42.AuthRepositoryImpl(authDataSource: gh<_i12.AuthDataSource>()));
    gh.factory<_i43.GetBrandsUseCase>(() =>
        _i43.GetBrandsUseCase(brandsRepository: gh<_i37.BrandsRepository>()));
    gh.factory<_i44.GetOrdersUseCase>(() =>
        _i44.GetOrdersUseCase(ordersRepository: gh<_i16.OrdersRepository>()));
    gh.factory<_i45.GetCategoriesUseCase>(() => _i45.GetCategoriesUseCase(
        categoriesRepository: gh<_i28.CategoriesRepository>()));
    gh.factory<_i46.GetProductsUseCase>(() => _i46.GetProductsUseCase(
        productRepository: gh<_i34.ProductRepository>()));
    gh.factory<_i47.CartRepository>(() =>
        _i48.CartRepositoryImpl(cartDataSource: gh<_i10.CartDataSource>()));
    gh.factory<_i49.OrdersViewModel>(() =>
        _i49.OrdersViewModel(getOrdersUseCase: gh<_i44.GetOrdersUseCase>()));
    gh.factory<_i50.GetProfileDataUseCase>(() => _i50.GetProfileDataUseCase(
        profileRepository: gh<_i39.ProfileRepository>()));
    gh.factory<_i51.GetFavoritesUseCase>(() => _i51.GetFavoritesUseCase(
        favoriteRepository: gh<_i32.FavoriteRepository>()));
    gh.factory<_i52.GetProductDetailsUseCase>(() =>
        _i52.GetProductDetailsUseCase(
            detailsRepository: gh<_i26.DetailsRepository>()));
    gh.factory<_i53.HomeTabVM>(() => _i53.HomeTabVM(
          getBannersUseCase: gh<_i36.GetBannersUseCase>(),
          getCategoriesUseCase: gh<_i45.GetCategoriesUseCase>(),
          getBrandsUseCase: gh<_i43.GetBrandsUseCase>(),
          getProductsUseCase: gh<_i46.GetProductsUseCase>(),
        ));
    gh.factory<_i54.GetCartItemsUseCase>(() =>
        _i54.GetCartItemsUseCase(cartRepository: gh<_i47.CartRepository>()));
    gh.factory<_i55.CategoryTabVM>(() => _i55.CategoryTabVM(
        getCategoriesUseCase: gh<_i45.GetCategoriesUseCase>()));
    gh.factory<_i56.ProductsTabVM>(() =>
        _i56.ProductsTabVM(getProductsUseCase: gh<_i46.GetProductsUseCase>()));
    gh.factory<_i57.SignInUseCase>(
        () => _i57.SignInUseCase(authRepository: gh<_i41.AuthRepository>()));
    gh.factory<_i58.SignUpUseCase>(
        () => _i58.SignUpUseCase(authRepository: gh<_i41.AuthRepository>()));
    gh.factory<_i59.ProfileTabVM>(() => _i59.ProfileTabVM(
        getProfileDataUseCase: gh<_i50.GetProfileDataUseCase>()));
    gh.factory<_i60.ProductDetailsVM>(() => _i60.ProductDetailsVM(
        getProductDetailsUseCase: gh<_i52.GetProductDetailsUseCase>()));
    gh.factory<_i61.FavoriteTabVM>(() => _i61.FavoriteTabVM(
        getFavoritesUseCase: gh<_i51.GetFavoritesUseCase>()));
    gh.factory<_i62.SignUpViewModel>(
        () => _i62.SignUpViewModel(signUpUseCase: gh<_i58.SignUpUseCase>()));
    gh.factory<_i63.CartVM>(
        () => _i63.CartVM(getCartItemsUseCase: gh<_i54.GetCartItemsUseCase>()));
    gh.factory<_i64.SignInViewModel>(
        () => _i64.SignInViewModel(signInUseCase: gh<_i57.SignInUseCase>()));
    return this;
  }
}
