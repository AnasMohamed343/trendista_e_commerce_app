import 'package:flutter/material.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/core/styles.dart';

typedef OnButtonClicked = void Function();

class CustomButtom extends StatelessWidget {
  String buttonTitle;
  OnButtonClicked onButtonClicked;
  Color? buttonTitleColor = kSecondaryColor;
  Color? buttonBackgroundColor = Colors.white;
  CustomButtom(
      {required this.buttonTitle,
      required this.onButtonClicked,
      this.buttonTitleColor,
      this.buttonBackgroundColor});
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
          top: w * 0.02, right: w * 0.01, left: w * 0.01, bottom: w * 0.015),
      child: ElevatedButton(
          // style: ButtonStyle(
          //   padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(19)),
          // ),
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsetsDirectional.all(w * 0.02),
          ),
          onPressed: () {
            onButtonClicked();
          },
          child: Text(
            buttonTitle,
            style: Styles.textStyle20(context).copyWith(
              color: buttonTitleColor,
            ),
          )),
    );
  }
}
