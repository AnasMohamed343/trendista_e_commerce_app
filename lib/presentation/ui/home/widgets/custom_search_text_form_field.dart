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
    final w = MediaQuery.of(context).size.width;
    return Container(
      height: w * 0.11,
      width: w,
      margin: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: w * 0.03),
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
            icon: Icon(
              Icons.search,
              color: kSecondaryColor,
              size: w * 0.05,
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
          hintStyle:
              Styles.textStyle16(context).copyWith(color: Colors.black26),
        ),
      ),
    );
  }
}
