import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trendista_e_commerce/constants.dart';

class CustomPageIndicator extends StatelessWidget {
  final PageController controller;
  double dotWidth;
  double dotHeight;
  int count;
  CustomPageIndicator(
      {super.key,
      required this.controller,
      required this.count,
      this.dotWidth = 6,
      this.dotHeight = 6});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      axisDirection: Axis.horizontal,
      effect: SlideEffect(
          spacing: 8.0,
          radius: w * 0.03,
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          paintStyle: PaintingStyle.stroke,
          strokeWidth: 1.5,
          dotColor: Colors.grey,
          activeDotColor: kSecondaryColor),
    );
  }
}
