import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trendista_e_commerce/core/ex.dart';
import 'package:trendista_e_commerce/core/styles.dart';
import 'package:trendista_e_commerce/core/ui_components/info_widget.dart';
import 'package:trendista_e_commerce/domain/entities/Category.dart';
//import 'package:trendista_e_commerce/domain/entities/route_e-commerce/Category.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/products_tab/products_tab.dart';

class CategoryItemWidget extends StatelessWidget {
  Category category;
  CategoryItemWidget({required this.category});
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
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
            InfoWidget(builder: (context, deviceInfo) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  height: deviceInfo.screenHeight * 0.07,
                  width: deviceInfo.screenWidth * 0.15,
                  imageUrl: category.image ?? '',
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              );
            }),
            SizedBox(height: h * 0.01),
            Text(
              category.name ?? '',
              maxLines: 1,
              style: Styles.textStyle16(context).copyWith(
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
