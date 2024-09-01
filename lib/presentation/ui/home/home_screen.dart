import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trendista_e_commerce/core/local/prefs_helper.dart';
import 'package:trendista_e_commerce/core/utils/routes_manager.dart';
import 'package:trendista_e_commerce/domain/entities/Category.dart';
import 'package:trendista_e_commerce/presentation/ui/home/home_screen_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/category_tab/category_tab.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/home_tab/home_tab_view.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/profile_tab/profile_tab.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/wish_list_tab/wish_list_tab.dart';

class HomeScreen extends StatelessWidget {
  //HomeScreen({super.key});
  int selectedIndex = 0;
  var viewModel = HomeScreenViewModel();
  Widget tabPreview = HomeTabView();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeScreenViewModel, HomeScreenState>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is HomeTabState) {
            tabPreview = HomeTabView();
          } else if (state is HomeCategoriesTabState) {
            tabPreview = CategoryTab();
          } else if (state is HomeWishListTabState) {
            tabPreview = WishListTab();
          } else {
            tabPreview = ProfileTab();
          }
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      logOut(context);
                    },
                    icon: Icon(Icons.logout))
              ],
              title: Text(
                'Trendista',
                style: GoogleFonts.almendra(
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff06004F),
                  //fontStyle: FontStyle.italic,
                ),
              ),
            ),
            bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                  ],
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    child: BottomNavigationBar(
                        currentIndex: selectedIndex,
                        onTap: (index) {
                          selectedIndex = index;
                          //setState(() {});
                          // or can handle the tabs by bloc :
                          viewModel.getTabs(selectedIndex);
                        },
                        backgroundColor: Color(0xff004182),
                        type: BottomNavigationBarType.fixed,
                        fixedColor: Color(0xff004182),
                        items: [
                          selectedIndex == 0
                              ? BottomNavigationBarItem(
                                  icon: CircleAvatar(
                                      child: ImageIcon(AssetImage(
                                          'assets/icons/ic_home.png'))),
                                  label: "")
                              : BottomNavigationBarItem(
                                  icon: ImageIcon(
                                      color: Colors.white,
                                      AssetImage('assets/icons/ic_home.png')),
                                  label: ""),
                          selectedIndex == 1
                              ? BottomNavigationBarItem(
                                  icon: CircleAvatar(
                                    child: ImageIcon(AssetImage(
                                        'assets/icons/ic_category.png')),
                                  ),
                                  label: "")
                              : BottomNavigationBarItem(
                                  icon: ImageIcon(
                                      color: Colors.white,
                                      AssetImage(
                                          'assets/icons/ic_category.png')),
                                  label: ""),
                          selectedIndex == 2
                              ? BottomNavigationBarItem(
                                  icon: CircleAvatar(
                                      child: ImageIcon(AssetImage(
                                          'assets/icons/ic_fav.png'))),
                                  label: "")
                              : BottomNavigationBarItem(
                                  icon: ImageIcon(
                                      color: Colors.white,
                                      AssetImage('assets/icons/ic_fav.png')),
                                  label: ""),
                          selectedIndex == 3
                              ? BottomNavigationBarItem(
                                  icon: CircleAvatar(
                                      child: ImageIcon(AssetImage(
                                          'assets/icons/ic_user.png'))),
                                  label: "")
                              : BottomNavigationBarItem(
                                  icon: ImageIcon(
                                      color: Colors.white,
                                      AssetImage('assets/icons/ic_user.png')),
                                  label: ""),
                        ]))),
            body: tabPreview,
            //tabs[selectedIndex],
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     Expanded(child: HomeTabView()),
            //   ],
            // ),
          );
        },
      ),
    );
  }

  void logOut(context) {
    PrefsHelper.clearToken();
    Navigator.pushReplacementNamed(context, RoutesManager.signInRouteName);
  }

  // List<Widget> tabs = [
  //   HomeTabView(),
  //   CategoryTab(),
  //   WishListTab(),
  //   ProfileTab(),
  // ];
}
