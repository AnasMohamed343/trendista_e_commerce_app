import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trendista_e_commerce/core/ui_components/info_widget.dart';
import 'package:trendista_e_commerce/domain/entities/BannerEntity.dart';

class BannerItemWidget extends StatelessWidget {
  final BannerEntity banner;
  const BannerItemWidget({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return AspectRatio(
      aspectRatio: 16 / 9.5,
      child: InfoWidget(builder: (context, deviceInfo) {
        return Container(
          height: deviceInfo.screenHeight * 0.21,
          margin: EdgeInsets.only(
              top: deviceInfo.screenHeight * 0.01,
              bottom: deviceInfo.screenHeight * 0.02,
              left: deviceInfo.screenWidth * 0.05,
              right: deviceInfo.screenWidth * 0.05),
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
        );
      }),
    );
  }
}
