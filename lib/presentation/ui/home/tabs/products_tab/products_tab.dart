import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:trendista_e_commerce/core/enums/device_type.dart';
import 'package:trendista_e_commerce/core/ui_components/info_widget.dart';
import 'package:trendista_e_commerce/di/di.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
//import 'package:trendista_e_commerce/domain/entities/route_e-commerce/Category.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/products_tab/products_tab_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/product_item_widget.dart';

import 'package:trendista_e_commerce/domain/entities/Category.dart';

class ProductsTab extends StatefulWidget {
  Category category;
  ProductsTab(this.category);

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  var viewModel = getIt<ProductsTabVM>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.repeat(period: const Duration(seconds: 3));
    viewModel.initPage(widget.category);
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
        appBar: AppBar(
          title: Text(widget.category.name ?? ''),
        ),
        body: BlocBuilder<ProductsTabVM, ProductsTabState>(
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
                              viewModel.initPage(widget.category);
                            },
                            child: const Text('Try Again'),
                          ),
                        ],
                      ),
                    );
                  }
                case SuccessState():
                  {
                    return InfoWidget(builder: (context, deviceInfo) {
                      double h = deviceInfo.screenHeight;
                      double w = deviceInfo.screenWidth;
                      return GridView.builder(
                        itemCount: state.products?.length,
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio:
                                deviceInfo.deviceType == DeviceType.Desktop
                                    ? w * 0.00099
                                    : deviceInfo.deviceType == DeviceType.Tablet
                                        ? w * 0.0012
                                        : deviceInfo.deviceType ==
                                                DeviceType.HugeDesktop
                                            ? w * 0.0008
                                            : w * 0.0018,
                            crossAxisCount: 2,
                            mainAxisSpacing: 0.0),
                        itemBuilder: (context, index) {
                          return ProductItemWidget(
                            product: state.products?[index] ?? Product(),
                          );
                        },
                      );
                    });
                  }
              }
            }));
  }
}
