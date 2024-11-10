import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendista_e_commerce/core/ui_components/info_widget.dart';
import 'package:trendista_e_commerce/domain/entities/Brand.dart';
import 'package:trendista_e_commerce/domain/entities/route_e-commerce/Category.dart';

class BrandItemWidget extends StatelessWidget {
  Brand brand;
  BrandItemWidget({required this.brand});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      child: InfoWidget(builder: (context, deviceInfo) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(80),
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            height: deviceInfo.screenHeight * 0.07,
            width: deviceInfo.screenWidth * 0.15,
            imageUrl: brand.image ?? '',
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        );
      }),
    );
  }
}
