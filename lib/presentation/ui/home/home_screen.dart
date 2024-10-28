import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/core/local/prefs_helper.dart';
import 'package:trendista_e_commerce/core/utils/assets_manager.dart';
import 'package:trendista_e_commerce/core/utils/routes_manager.dart';
import 'package:trendista_e_commerce/domain/entities/route_e-commerce/Category.dart';
import 'package:trendista_e_commerce/presentation/ui/home/home_screen_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/category_tab/category_tab.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/favorite_tab/favorite_list_tab.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/home_tab/home_tab_view.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/profile_tab/profile_tab.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_app_bar.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  int selectedIndex = 0;
  var viewModel = HomeScreenViewModel();
  Widget tabPreview = HomeTabView();

  List<String> tabsName = ['Trendista', 'Categories', 'Favorites', 'Profile'];
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
            tabPreview = FavoriteListTab();
          } else {
            tabPreview = ProfileTab();
          }
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              // actions: [
              //   IconButton(
              //       onPressed: () {
              //         logOut(context);
              //       },
              //       icon: const Icon(Icons.logout))
              // ],
              backgroundColor: Colors.white,
              title: Text(tabsName[selectedIndex],
                  style: GoogleFonts.almendra(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: kPrimaryColor,
                    //fontStyle: FontStyle.italic,
                  )),
            ),
            bottomNavigationBar: Container(
                decoration: const BoxDecoration(
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
                    borderRadius: const BorderRadius.only(
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
                        backgroundColor: kPrimaryColor,
                        type: BottomNavigationBarType.fixed,
                        fixedColor: kPrimaryColor,
                        items: [
                          selectedIndex == 0
                              ? const BottomNavigationBarItem(
                                  icon: CircleAvatar(
                                      child: ImageIcon(AssetImage(
                                          'assets/icons/ic_home.png'))),
                                  label: "")
                              : const BottomNavigationBarItem(
                                  icon: ImageIcon(
                                      color: Colors.white,
                                      AssetImage('assets/icons/ic_home.png')),
                                  label: ""),
                          selectedIndex == 1
                              ? const BottomNavigationBarItem(
                                  icon: CircleAvatar(
                                    child: ImageIcon(AssetImage(
                                        'assets/icons/ic_category.png')),
                                  ),
                                  label: "")
                              : const BottomNavigationBarItem(
                                  icon: ImageIcon(
                                      color: Colors.white,
                                      AssetImage(
                                          'assets/icons/ic_category.png')),
                                  label: ""),
                          selectedIndex == 2
                              ? BottomNavigationBarItem(
                                  icon: CircleAvatar(
                                      child: SvgPicture.asset(
                                    AssetsManager.favIcon,
                                    color: Colors.black,
                                  )),
                                  label: "")
                              : BottomNavigationBarItem(
                                  icon: SvgPicture.asset(
                                    AssetsManager.favIcon,
                                    color: Colors.white,
                                  ),
                                  label: ""),
                          selectedIndex == 3
                              ? const BottomNavigationBarItem(
                                  icon: CircleAvatar(
                                      child: ImageIcon(AssetImage(
                                          'assets/icons/ic_user.png'))),
                                  label: "")
                              : const BottomNavigationBarItem(
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

  // List<Widget> tabs = [
  //   HomeTabView(),
  //   CategoryTab(),
  //   WishListTab(),
  //   ProfileTab(),
  // ];
}
