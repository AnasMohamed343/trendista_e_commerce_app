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
      this.dotWidth = 10,
      this.dotHeight = 2});

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      axisDirection: Axis.horizontal,
      effect: SlideEffect(
          spacing: 8.0,
          radius: 30,
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          paintStyle: PaintingStyle.stroke,
          strokeWidth: 1.5,
          dotColor: Colors.grey,
          activeDotColor: kSecondaryColor),
    );
  }
}
