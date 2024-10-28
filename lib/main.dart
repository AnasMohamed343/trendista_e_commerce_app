import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:trendista_e_commerce/core/local/prefs_helper.dart';
import 'package:trendista_e_commerce/core/utils/routes_manager.dart';
import 'package:trendista_e_commerce/di/di.dart';
import 'package:trendista_e_commerce/domain/usecases/get_cartitems_usecase.dart';
import 'package:trendista_e_commerce/domain/usecases/get_favorites_usecase.dart';
import 'package:trendista_e_commerce/domain/usecases/get_product_details_usecase.dart';
import 'package:trendista_e_commerce/presentation/ui/details_screen/product_details_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/home_screen.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/carts/cart_screen.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/carts/cart_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/favorite_tab/favorite_tab_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/home_tab/home_tab_view.dart';
import 'package:trendista_e_commerce/presentation/ui/sign_in/sign_in_screen.dart';
import 'package:trendista_e_commerce/presentation/ui/sign_up/sign_up_screen.dart';
import 'package:trendista_e_commerce/providers/favorite_provider.dart';

import 'constants.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // to wait until the await function finish
  await PrefsHelper.init();
  //token = PrefsHelper.getToken(key: token ?? '');
  print('token is ${PrefsHelper.getToken()}');
  configureDependencies();
  runApp(
    MultiProvider(
      providers: [
        // Other providers...
        // BlocProvider<FavoriteTabVM>(
        //   create: (context) =>
        //       FavoriteTabVM(getFavoritesUseCase: getIt<GetFavoritesUseCase>()),
        // ),
        ChangeNotifierProvider(
            create: (_) => FavoriteProvider(
                getFavoritesUseCase: getIt<GetFavoritesUseCase>(),
                getProductDetailsUseCase: getIt<GetProductDetailsUseCase>())),
        BlocProvider<CartVM>(
            create: (context) =>
                CartVM(getCartItemsUseCase: getIt<GetCartItemsUseCase>())),
        BlocProvider<ProductDetailsVM>(
            create: (context) => ProductDetailsVM(
                getProductDetailsUseCase: getIt<GetProductDetailsUseCase>())),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932), // the size of the screen
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        routes: {
          RoutesManager.signUpRouteName: (context) => SignUpScreen(),
          RoutesManager.signInRouteName: (context) => SignInScreen(),
          RoutesManager.homeRouteName: (context) => HomeScreen(),
          RoutesManager.cartRouteName: (context) => CartScreen(),
        },
        initialRoute:
            PrefsHelper.getToken().isNotEmpty //token != null && token != '' //
                ? RoutesManager.homeRouteName
                : RoutesManager.signInRouteName,
      ),
    );
  }
}
