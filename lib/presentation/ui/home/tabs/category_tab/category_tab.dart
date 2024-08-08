import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendista_e_commerce/di/di.dart';
import 'package:trendista_e_commerce/domain/entities/Category.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/home_tab/category_item_widget.dart';

import 'category_tab_vm.dart';
import 'category_tab_widget.dart';

class CategoryTab extends StatefulWidget {
  List<Category>? categories; // Change the type to List<Category>?
  CategoryTab({this.categories});

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  CategoryTabVM viewModel = getIt.get<CategoryTabVM>(); //////

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.initPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: TextStyle(
            color: Color(0xff06004F),
            fontSize: 17,
          ),
        ),
      ),
      body: BlocBuilder<CategoryTabVM, CategoryTabState>(
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
                  if (widget.categories != null) {
                    return GridView.builder(
                      itemCount: widget.categories?.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return CategoryTabWidget(
                            category: widget.categories![index]);
                      },
                    );
                  } else {
                    return GridView.builder(
                      itemCount: state.categories?.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return CategoryTabWidget(
                            category: state.categories![index]);
                      },
                    );
                  }
                }
            }
          }),
    );
  }
}
