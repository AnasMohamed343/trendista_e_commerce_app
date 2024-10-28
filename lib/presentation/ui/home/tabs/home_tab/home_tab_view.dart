import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/core/ex.dart';
import 'package:trendista_e_commerce/core/styles.dart';
import 'package:trendista_e_commerce/di/di.dart';
import 'package:trendista_e_commerce/domain/entities/BannerEntity.dart';
import 'package:trendista_e_commerce/domain/entities/Brand.dart';
import 'package:trendista_e_commerce/domain/entities/Category.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/category_tab/category_tab.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/favorite_tab/favorite_tab_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/home_tab/banner_item_widget.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/home_tab/brand_item_widget.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/home_tab/category_item_widget.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/home_tab/home_tab_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_page_indicator.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_search_text_form_field.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/product_item_widget.dart';

class HomeTabView extends StatefulWidget {
  Category? category;
  HomeTabView([this.category]);
  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  HomeTabVM viewModel = getIt.get<HomeTabVM>();
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    viewModel.initPage();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeTabVM, HomeTabState>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is LoadingState) {
          double h = MediaQuery.of(context).size.height;
          return Skeletonizer(
            enabled: true,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: CustomSearchTextField(),
                ),
                SliverToBoxAdapter(
                  child: BannerItemWidget(banner: getDummyBanners()[0]),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: h * 0.12,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => CategoryItemWidget(
                          category: getDummyCategories()[index]),
                      itemCount: getDummyCategories().length,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: h * 0.1,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          BrandItemWidget(brand: getDummyBrands()[index]),
                      itemCount: getDummyBrands()
                          .length, // Adjust the item count as needed
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: h * 0.3,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          ProductItemWidget(product: getDummyProducts()[index]),
                      itemCount: getDummyProducts()
                          .length, // Adjust the item count as needed
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is ErrorState) {
          return Center(
            child: Column(
              children: [
                Expanded(child: Text(state.errorMessage ?? '')),
                ElevatedButton(
                  onPressed: () {
                    viewModel.initPage();
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        } else if (state is SuccessState) {
          double h = MediaQuery.of(context).size.height;
          var categories = state.categories;
          var brands = state.brands;
          var products = state.products;
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    CustomSearchTextField(
                      textFieldTitle: 'What do you search for?',
                      // onChanged: (value) {
                      //   viewModel.searchProducts(value);
                      // },
                      onSubmitted: (value) {
                        viewModel.searchProducts(value);
                      },
                    ),
                    SizedBox(
                      height: h * 0.24,
                      width: double.infinity,
                      child: PageView.builder(
                        controller: pageController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.banners?.length ?? 0, //4
                        itemBuilder: (context, index) {
                          return BannerItemWidget(
                              banner: state.banners?[index] ?? BannerEntity());
                        },
                      ),
                    ),
                    CustomPageIndicator(
                      controller: pageController,
                      count: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 17, vertical: 8),
                      child: Row(
                        children: [
                          Text(
                            'Categories',
                            style: Styles.textStyle18.copyWith(
                              color: kPrimaryColor,
                            ),
                          ),
                          const Spacer(),
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
                              style: Styles.textStyle15.copyWith(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: h * 0.12,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            CategoryItemWidget(category: categories![index]),
                        itemCount: categories?.length,
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: h * 0.09,
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
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) => ProductItemWidget(
                        product: state.filteredProducts!.isEmpty
                            ? products![index]
                            : state.filteredProducts![index]),
                    itemCount: state.filteredProducts!.isEmpty
                        ? state.products?.length
                        : state.filteredProducts?.length,
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink(); // or any other default widget
        }
      },
    );
  }
}

List<Category> getDummyCategories() {
  return [
    Category(name: 'Hoodies', image: 'https://via.placeholder.com/150'),
    Category(name: 'Hoodies', image: 'https://via.placeholder.com/150'),
    Category(name: 'Hoodies', image: 'https://via.placeholder.com/150'),
    Category(name: 'Hoodies', image: 'https://via.placeholder.com/150'),
  ];
}

List<BannerEntity> getDummyBanners() {
  return [
    BannerEntity(image: 'https://via.placeholder.com/150'),
  ];
}

List<Brand> getDummyBrands() {
  return [
    Brand(name: 'Brand 3', image: 'https://via.placeholder.com/150'),
    Brand(name: 'Brand 3', image: 'https://via.placeholder.com/150'),
    Brand(name: 'Brand 3', image: 'https://via.placeholder.com/150'),
    Brand(name: 'Brand 3', image: 'https://via.placeholder.com/150'),
  ];
}

List<Product> getDummyProducts() {
  return [
    Product(
      name: 'Shoes',
      image: 'https://via.placeholder.com/150',
      description: 'hchghtyfcyd',
      price: 785,
      oldPrice: 875,
    ),
    Product(
      name: 'Shoes',
      image: 'https://via.placeholder.com/150',
      description: 'hchghtyfcyd',
      price: 785,
      oldPrice: 875,
    ),
  ];
}
