import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef OnButtonClicked = void Function();

class CustomButtom extends StatelessWidget {
  String buttonTitle;
  OnButtonClicked onButtonClicked;
  CustomButtom({required this.buttonTitle, required this.onButtonClicked});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 8, left: 8, bottom: 10),
      child: ElevatedButton(
          // style: ButtonStyle(
          //   padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(19)),
          // ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            padding: EdgeInsets.all(24),
          ),
          onPressed: () {
            onButtonClicked();
          },
          child: Text(
            buttonTitle,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff004182),
            ),
          )),
    );
  }
}
