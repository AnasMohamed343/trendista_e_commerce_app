import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef Validation = String? Function(String?);

class CustomTextFormField extends StatefulWidget {
  String hintText, formFieldTitle;
  Validation validator;
  TextEditingController controller;
  bool isPassword;
  TextInputType keyboardType;
  int? maxLength;
  CustomTextFormField({
    required this.hintText,
    required this.formFieldTitle,
    required this.validator,
    required this.controller,
    this.isPassword = false,
    required this.keyboardType,
    this.maxLength,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.formFieldTitle,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 7.h,
          ),
          TextFormField(
            validator: widget.validator,
            controller: widget.controller,
            obscureText: widget.isPassword ? _obscureText : false,
            maxLength: widget.maxLength,
            keyboardType: widget
                .keyboardType, // to make if the TextFormField was the password => the keyboard open on the numbers, and if the TextFormField was userName or ... to open on the characters
            style: TextStyle(),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.black87),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ))
                    : null),
          ),
        ],
      ),
    );
  }
}
