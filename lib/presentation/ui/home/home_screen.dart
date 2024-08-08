import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trendista_e_commerce/domain/entities/Category.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/category_tab/category_tab.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/home_tab/home_tab_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
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
                      setState(() {});
                    },
                    backgroundColor: Color(0xff004182),
                    type: BottomNavigationBarType.fixed,
                    fixedColor: Color(0xff004182),
                    items: [
                      selectedIndex == 0
                          ? BottomNavigationBarItem(
                              icon: CircleAvatar(
                                  child: ImageIcon(
                                      AssetImage('assets/icons/ic_home.png'))),
                              label: "")
                          : BottomNavigationBarItem(
                              icon: ImageIcon(
                                  color: Colors.white,
                                  AssetImage('assets/icons/ic_home.png')),
                              label: ""),
                      selectedIndex == 1
                          ? BottomNavigationBarItem(
                              icon: CircleAvatar(
                                child: ImageIcon(
                                    AssetImage('assets/icons/ic_category.png')),
                              ),
                              label: "")
                          : BottomNavigationBarItem(
                              icon: ImageIcon(
                                  color: Colors.white,
                                  AssetImage('assets/icons/ic_category.png')),
                              label: ""),
                      selectedIndex == 2
                          ? BottomNavigationBarItem(
                              icon: CircleAvatar(
                                  child: ImageIcon(
                                      AssetImage('assets/icons/ic_fav.png'))),
                              label: "")
                          : BottomNavigationBarItem(
                              icon: ImageIcon(
                                  color: Colors.white,
                                  AssetImage('assets/icons/ic_fav.png')),
                              label: ""),
                      selectedIndex == 3
                          ? BottomNavigationBarItem(
                              icon: CircleAvatar(
                                  child: ImageIcon(
                                      AssetImage('assets/icons/ic_user.png'))),
                              label: "")
                          : BottomNavigationBarItem(
                              icon: ImageIcon(
                                  color: Colors.white,
                                  AssetImage('assets/icons/ic_user.png')),
                              label: ""),
                    ]))),
        body: tabs[selectedIndex],
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Expanded(child: HomeTabView()),
        //   ],
        // ),
      ),
    );
  }

  List<Widget> tabs = [
    HomeTabView(),
    CategoryTab(),
    HomeTabView(),
    HomeTabView(),
  ];
}
