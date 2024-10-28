import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trendista_e_commerce/core/ex.dart';
import 'package:trendista_e_commerce/core/styles.dart';
import 'package:trendista_e_commerce/domain/entities/Category.dart';
//import 'package:trendista_e_commerce/domain/entities/route_e-commerce/Category.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/products_tab/products_tab.dart';

class CategoryItemWidget extends StatelessWidget {
  Category category;
  CategoryItemWidget({required this.category});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ProductsTab(category).goTo();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                height: 65,
                width: 80,
                imageUrl: category.image ?? '',
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              category.name ?? '',
              maxLines: 1,
              style: Styles.textStyle16.copyWith(
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
