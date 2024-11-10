import 'package:flutter/material.dart';

double getResponsiveFontSize(BuildContext context, double percentage) {
  double screenWidth = MediaQuery.of(context).size.width;
  return screenWidth *
      percentage /
      100; // Calculate font size based on percentage of screen width
}
