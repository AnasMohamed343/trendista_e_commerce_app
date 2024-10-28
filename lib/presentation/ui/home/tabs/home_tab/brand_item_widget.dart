import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendista_e_commerce/domain/entities/Brand.dart';
import 'package:trendista_e_commerce/domain/entities/route_e-commerce/Category.dart';

class BrandItemWidget extends StatelessWidget {
  Brand brand;
  BrandItemWidget({required this.brand});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(80),
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          height: 80.h,
          width: 90.w,
          imageUrl: brand.image ?? '',
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
