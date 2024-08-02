import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendista_e_commerce/di/di.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/home_tab/category_item_widget.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/home_tab/home_tab_vm.dart';

class HomeTabView extends StatefulWidget {
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
              var categories = state.categories;
              return Expanded(
                child: GridView.builder(
                  //padding: EdgeInsets.all(10),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) =>
                      CategoryItemWidget(category: categories![index]),
                  itemCount: categories?.length,
                ),
              );
            }
        }
      },
    );
  }
}
