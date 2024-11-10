import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trendista_e_commerce/core/ex.dart';
import 'package:trendista_e_commerce/core/styles.dart';
//import 'package:trendista_e_commerce/domain/entities/route_e-commerce/Category.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/products_tab/products_tab.dart';

import 'package:trendista_e_commerce/domain/entities/Category.dart';

class CategoryTabWidget extends StatelessWidget {
  Category category;
  CategoryTabWidget({required this.category});
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        // ProductsTab(category).goTo();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductsTab(category),
          ),
        );
      },
      child: Container(
        height: h * 0.12,
        width: w * 0.20,
        margin: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  // height: h * 0.07,
                  // width: w * 0.15,
                  imageUrl: category.image ?? '',
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(
              height: h * 0.01,
            ),
            Expanded(
              flex: 2,
              child: Text(
                category.name ?? '',
                maxLines: 1,
                style: Styles.textStyle18(context).copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
