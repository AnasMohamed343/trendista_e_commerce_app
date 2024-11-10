import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:trendista_e_commerce/core/local/prefs_helper.dart';
import 'package:trendista_e_commerce/core/utils/routes_manager.dart';
import 'package:trendista_e_commerce/di/di.dart';
import 'package:trendista_e_commerce/domain/usecases/get_cartitems_usecase.dart';
import 'package:trendista_e_commerce/domain/usecases/get_favorites_usecase.dart';
import 'package:trendista_e_commerce/domain/usecases/get_orders_usecase.dart';
import 'package:trendista_e_commerce/domain/usecases/get_product_details_usecase.dart';
import 'package:trendista_e_commerce/domain/usecases/get_profiledata_usecase.dart';
import 'package:trendista_e_commerce/presentation/ui/product_details_screen/product_details_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/home_screen.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/carts/cart_screen.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/carts/cart_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/favorite_tab/favorite_tab_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/home_tab/home_tab_view.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/profile_tab/orders_screen/orders_screen.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/profile_tab/orders_screen/orders_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/profile_tab/profile_tab.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/profile_tab/profile_tab_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/sign_in/sign_in_screen.dart';
import 'package:trendista_e_commerce/presentation/ui/sign_up/sign_up_screen.dart';
import 'package:trendista_e_commerce/providers/favorite_provider.dart';

import 'constants.dart';
import 'presentation/ui/home/tabs/profile_tab/edit_profile.dart';

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
        // BlocProvider<CartVM>(
        //     create: (context) =>
        //         CartVM(getCartItemsUseCase: getIt<GetCartItemsUseCase>())),
        ChangeNotifierProvider(
          create: (context) =>
              CartVM(getCartItemsUseCase: getIt<GetCartItemsUseCase>()),
        ),
        BlocProvider<ProductDetailsVM>(
            create: (context) => ProductDetailsVM(
                getProductDetailsUseCase: getIt<GetProductDetailsUseCase>())),
        BlocProvider<ProfileTabVM>(
          create: (context) => ProfileTabVM(
              getProfileDataUseCase: getIt<GetProfileDataUseCase>()),
        ),
        BlocProvider<OrdersViewModel>(
            create: (context) => OrdersViewModel(
                  getOrdersUseCase: getIt<GetOrdersUseCase>(),
                )),
      ],
      child: MyApp(), //DevicePreview(builder: (context) => MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // double screenHeight = ScreenUtil().screenHeight;
    // double screenWidth = ScreenUtil().screenWidth;
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      //builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      routes: {
        RoutesManager.signUpRouteName: (context) => SignUpScreen(),
        RoutesManager.signInRouteName: (context) => SignInScreen(),
        RoutesManager.homeRouteName: (context) => HomeScreen(),
        RoutesManager.cartRouteName: (context) => CartScreen(),
        RoutesManager.profileTabRouteName: (context) => ProfileTab(),
        RoutesManager.editProfileRouteName: (context) => EditProfileScreen(),
        RoutesManager.ordersScreenRouteName: (context) => OrdersScreen(),
      },
      initialRoute:
          PrefsHelper.getToken().isNotEmpty //token != null && token != '' //
              ? RoutesManager.homeRouteName
              : RoutesManager.signInRouteName,
    );
  }
}
