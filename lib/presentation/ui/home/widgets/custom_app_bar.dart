import 'package:flutter/material.dart';
import 'package:trendista_e_commerce/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String appbarTitle;
  CustomAppBar({super.key, required this.appbarTitle});

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        appbarTitle,
        style: const TextStyle(
            color: kPrimaryColor, fontSize: 19, fontWeight: FontWeight.bold),
      ),
    );
  }
}