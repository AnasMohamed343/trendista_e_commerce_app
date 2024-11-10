import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/core/styles.dart';

typedef Validation = String? Function(String?);

class CustomTextFormField extends StatefulWidget {
  String hintText, formFieldTitle;
  Validation validator;
  TextEditingController controller;
  bool isPassword;
  TextInputType keyboardType;
  int? maxLength;
  Color? borderSideColor;
  Widget? suffixIcon;
  CustomTextFormField({
    required this.hintText,
    required this.formFieldTitle,
    required this.validator,
    required this.controller,
    this.isPassword = false,
    required this.keyboardType,
    this.maxLength,
    this.borderSideColor,
    this.suffixIcon,
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
    final w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.formFieldTitle,
            textAlign: TextAlign.start,
            style: Styles.textStyle18(context).copyWith(color: Colors.white),
          ),
          SizedBox(
            height: w * 0.01,
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
                hintStyle: Styles.textStyle16(context).copyWith(
                    color: Colors.black87, fontWeight: FontWeight.w300),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.borderSideColor ?? kPrimaryColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.borderSideColor ?? kPrimaryColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.borderSideColor ?? kPrimaryColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          size: w * 0.03,
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ))
                    : widget.suffixIcon),
          ),
        ],
      ),
    );
  }
}
