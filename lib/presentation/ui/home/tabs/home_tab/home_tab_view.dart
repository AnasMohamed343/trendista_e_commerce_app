import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendista_e_commerce/core/ex.dart';
import 'package:trendista_e_commerce/di/di.dart';
import 'package:trendista_e_commerce/domain/entities/Category.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/category_tab/category_tab.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/home_tab/brand_item_widget.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/home_tab/category_item_widget.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/home_tab/home_tab_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/product_item_widget.dart';

class HomeTabView extends StatefulWidget {
  Category? category;
  HomeTabView([this.category]);
  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  HomeTabVM viewModel = getIt.get<HomeTabVM>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.initPage();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeTabVM, HomeTabState>(
      bloc: viewModel,
      builder: (context, state) {
        switch (state) {
          case LoadingState():
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          case ErrorState():
            {
              return Center(
                child: Column(
                  children: [
                    Expanded(child: Text(state.errorMessage ?? '')),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Try Again'),
                    ),
                  ],
                ),
              );
            }
          case SuccessState():
            {
              double h = MediaQuery.of(context).size.height;
              var categories = state.categories;
              var brands = state.brands;
              var products = state.products;
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: Row(
                            children: [
                              Text(
                                'Categories',
                                style: TextStyle(
                                  color: Color(0xff06004F),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CategoryTab(
                                        categories:
                                            categories, // Pass the categories to CategoryTab
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  'view All',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: h * 0.4,
                          child: GridView.builder(
                            //padding: EdgeInsets.all(10),
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              // crossAxisSpacing: 18,
                              // mainAxisSpacing: 18,
                              //childAspectRatio: 1 / 2,
                            ),
                            itemBuilder: (context, index) => CategoryItemWidget(
                                category: categories![index]),
                            itemCount: categories?.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: h * 0.1,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            BrandItemWidget(brand: brands![index]),
                        itemCount: brands?.length,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: h * 0.3,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            ProductItemWidget(product: products![index]),
                        itemCount: products?.length,
                      ),
                    ),
                  ),
                ],
              );
            }
        }
      },
    );
  }
}
