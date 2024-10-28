import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trendista_e_commerce/domain/entities/BannerEntity.dart';

class BannerItemWidget extends StatelessWidget {
  final BannerEntity banner;
  const BannerItemWidget({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return AspectRatio(
      aspectRatio: 16 / 9.5,
      child: Container(
        height: h * 0.21,
        margin: const EdgeInsets.only(top: 4, bottom: 15, left: 17, right: 17),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              banner.image ?? '',
            ),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.darken,
            ),
          ),
        ),
      ),
    );
  }
}
