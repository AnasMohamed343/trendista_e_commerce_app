import 'package:flutter/material.dart';
import 'package:trendista_e_commerce/domain/entities/Category.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/home_tab/home_tab_view.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // double h = MediaQuery.of(context).size.height;
    // double w = MediaQuery.of(context).size.width;
    // var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Trendista',
            style: TextStyle(
                color: Color(0xff06004F),
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                  height: 390,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Categories',
                              style: TextStyle(
                                color: Color(0xff06004F),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'view All',
                              style: TextStyle(
                                color: Color(0xff06004F),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      HomeTabView(),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
