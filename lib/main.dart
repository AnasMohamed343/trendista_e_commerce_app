import 'package:flutter/material.dart';
import 'package:trendista_e_commerce/di/di.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/home_tab/home_screen.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/home_tab/home_tab_view.dart';

void main() {
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
