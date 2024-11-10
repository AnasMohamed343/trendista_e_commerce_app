import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:trendista_e_commerce/di/di.dart';
//import 'package:trendista_e_commerce/domain/entities/route_e-commerce/Category.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/home_tab/category_item_widget.dart';

import 'package:trendista_e_commerce/domain/entities/Category.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_app_bar.dart';

import 'category_tab_vm.dart';
import 'category_tab_widget.dart';

class CategoryTab extends StatefulWidget {
  List<Category>? categories;
  CategoryTab({this.categories});

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  CategoryTabVM viewModel = getIt.get<CategoryTabVM>(); //////
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.repeat(period: const Duration(seconds: 3));
    viewModel.initPage();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      //appBar: CustomAppBar(appbarTitle: 'Categories'),
      body: BlocBuilder<CategoryTabVM, CategoryTabState>(
          bloc:
              viewModel, // can call the func initPage() here like this => viewModel..initPage() , or call it in the initState like i do above.
          builder: (context, state) {
            switch (state) {
              case LoadingState():
                {
                  return Center(
                    child: Lottie.network(
                        'https://lottie.host/f45c9991-322a-4fe7-bf28-1b08fcb62e6c/xBEyXbOlwu.json',
                        width: w * 0.6,
                        height: h * 0.6,
                        repeat: true,
                        errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error_outline);
                    }, controller: _controller),
                  );
                }
              case ErrorState():
                {
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
                }
              case SuccessState():
                {
                  if (state.categories != null) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Row(
                        //   children: [
                        //     IconButton(
                        //         onPressed: () {
                        //           Navigator.pop(context);
                        //         },
                        //         icon: const Icon(Icons.arrow_back)),
                        //     const Text(
                        //       'Categories',
                        //       style:
                        //           TextStyle(fontSize: 20, color: Colors.black),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: h * 0.04,
                        ),
                        Expanded(
                          child: GridView.builder(
                            itemCount: state.categories?.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              return CategoryTabWidget(
                                  category: state.categories![index]);
                            },
                          ),
                        ),
                      ],
                    );
                  }

                  return Container();
                }
            }
          }),
    );
  }
}
