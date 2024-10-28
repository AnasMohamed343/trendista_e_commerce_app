import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Styles {
  static const textStyle16 =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white);
  static const textStyle15 =
      TextStyle(fontWeight: FontWeight.normal, fontSize: 15);
  static const textStyle13 = TextStyle(
      decorationColor: Colors.blue,
      fontSize: 13,
      color: Colors.blue,
      decoration: TextDecoration.lineThrough);
  static const textStyle14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
  static const textStyle20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static const textStyle18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static const textStyle24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
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
}
