import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trendista_e_commerce/core/helper_functions/get_responsive_fontsize.dart';

abstract class Styles {
  static TextStyle textStyle24(BuildContext context) => TextStyle(
        fontSize: getResponsiveFontSize(context, 4.1),
        fontWeight: FontWeight.w600,
      );
  static TextStyle textStyle20(BuildContext context) => TextStyle(
        fontSize: getResponsiveFontSize(context, 3.7),
        fontWeight: FontWeight.w600,
      );
  static TextStyle textStyle18(BuildContext context) => TextStyle(
        fontSize: getResponsiveFontSize(context, 3.5),
        fontWeight: FontWeight.w500,
      );
  static TextStyle textStyle16(BuildContext context) => TextStyle(
        fontSize: getResponsiveFontSize(context, 3.3),
        fontWeight: FontWeight.w700,
        color: Colors.white,
      );
  static TextStyle textStyle15(BuildContext context) => TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: getResponsiveFontSize(context, 3.2),
      );
  static TextStyle textStyle14(BuildContext context) => TextStyle(
        fontSize: getResponsiveFontSize(context, 3.1),
        fontWeight: FontWeight.normal,
      );
  static TextStyle textStyle13(BuildContext context) => TextStyle(
        decorationColor: Colors.blue,
        fontSize: getResponsiveFontSize(context, 3),
        color: Colors.blue,
        decoration: TextDecoration.lineThrough,
      );
}
// static TextStyle textStyle22 = GoogleFonts.almendra(
//   textStyle: TextStyle(
//     fontSize: 22,
//     fontWeight: FontWeight.bold,
//   ),
//   fontSize: 42,
//   fontWeight: FontWeight.w700,
//   color: Colors.white,
//   //fontStyle: FontStyle.italic,
// );

//
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
//
// abstract class Styles {
//   static const textStyle16 =
//   TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white);
//   static const textStyle15 =
//   TextStyle(fontWeight: FontWeight.normal, fontSize: 15);
//   static const textStyle13 = TextStyle(
//       decorationColor: Colors.blue,
//       fontSize: 13,
//       color: Colors.blue,
//       decoration: TextDecoration.lineThrough);
//   static const textStyle14 = TextStyle(
//     fontSize: 14,
//     fontWeight: FontWeight.normal,
//   );
//   static const textStyle20 = TextStyle(
//     fontSize: 20,
//     fontWeight: FontWeight.w600,
//   );
//   static const textStyle18 = TextStyle(
//     fontSize: 18,
//     fontWeight: FontWeight.w500,
//   );
//   static const textStyle24 = TextStyle(
//     fontSize: 24,
//     fontWeight: FontWeight.w600,
//   );
// // static TextStyle textStyle22 = GoogleFonts.almendra(
// //   textStyle: TextStyle(
// //     fontSize: 22,
// //     fontWeight: FontWeight.bold,
// //   ),
// //   fontSize: 42,
// //   fontWeight: FontWeight.w700,
// //   color: Colors.white,
// //   //fontStyle: FontStyle.italic,
// // );
// }
