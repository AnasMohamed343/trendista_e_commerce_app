import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trendista_e_commerce/core/styles.dart';

class CustomConfirmationOrderWidget extends StatelessWidget {
  final String confirmMessage;
  final String confirmMessageTitle;
  final IconData? icon;
  final Color? iconBackgroundColor;
  const CustomConfirmationOrderWidget(
      {super.key,
      required this.confirmMessage,
      this.icon,
      this.iconBackgroundColor,
      required this.confirmMessageTitle});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: iconBackgroundColor,
          size: w * 0.2,
          weight: 100,
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              confirmMessageTitle,
              style: Styles.textStyle20(context)
                  .copyWith(fontWeight: FontWeight.w800),
            ),
            Text(
              confirmMessage,
              style: Styles.textStyle18(context).copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
