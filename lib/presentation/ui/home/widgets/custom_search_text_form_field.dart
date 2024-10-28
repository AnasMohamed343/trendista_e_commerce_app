import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/core/styles.dart';

class CustomSearchTextField extends StatelessWidget {
  String? textFieldTitle;
  void Function(String)? onChanged;
  void Function()? onTap;
  void Function(String)? onSubmitted;
  final TextEditingController _controller = TextEditingController();

  CustomSearchTextField({
    this.textFieldTitle,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: TextField(
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        controller: _controller,
        cursorColor: kBorderColor,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: textFieldTitle,
          prefixIcon: IconButton(
            onPressed: () {
              onSubmitted!(_controller.text);
            },
            icon: const Icon(
              Icons.search,
              color: kSecondaryColor,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: kBorderColor),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: kBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: kBorderColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: kBorderColor),
          ),
          hintStyle: Styles.textStyle14.copyWith(color: Colors.black26),
        ),
      ),
    );
  }
}
