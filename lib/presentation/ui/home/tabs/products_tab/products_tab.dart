import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendista_e_commerce/di/di.dart';
import 'package:trendista_e_commerce/domain/entities/Category.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/products_tab/products_tab_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/product_item_widget.dart';

class ProductsTab extends StatefulWidget {
  Category category;
  ProductsTab(this.category);

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  var viewModel = getIt<ProductsTabVM>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.initPage(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    return GridView.builder(
                      itemCount: state.products?.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 8 / 9.8,
                          crossAxisCount: 2,
                          mainAxisSpacing: 12),
                      itemBuilder: (context, index) {
                        return ProductItemWidget(
                            product: state.products![index]);
                      },
                    );
                  }
              }
            }));
  }
}
