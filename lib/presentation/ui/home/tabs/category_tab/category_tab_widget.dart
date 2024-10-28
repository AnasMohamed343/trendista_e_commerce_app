import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        height: 100.h,
        width: 100.w,
        margin: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                height: 95.h,
                width: 100.w,
                imageUrl: category.image ?? '',
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            SizedBox(
              height: 9.h,
            ),
            Text(
              category.name ?? '',
              maxLines: 1,
              style: Styles.textStyle15.copyWith(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
