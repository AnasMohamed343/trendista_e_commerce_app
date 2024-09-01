import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendista_e_commerce/core/local/prefs_helper.dart';
import 'package:trendista_e_commerce/core/utils/routes_manager.dart';
import 'package:trendista_e_commerce/di/di.dart';
import 'package:trendista_e_commerce/presentation/ui/home/home_screen.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/home_tab/home_tab_view.dart';
import 'package:trendista_e_commerce/presentation/ui/sign_in/sign_in_screen.dart';
import 'package:trendista_e_commerce/presentation/ui/sign_up/sign_up_screen.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // to wait until the await function finish
  await PrefsHelper.init();
  configureDependencies();
  runApp(MyApp());
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
        },
        initialRoute: PrefsHelper.getToken().isNotEmpty
            ? RoutesManager.homeRouteName
            : RoutesManager.signInRouteName,
      ),
    );
  }
}
